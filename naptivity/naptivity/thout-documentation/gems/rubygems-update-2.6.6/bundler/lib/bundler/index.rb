# frozen_string_literal: true
require "set"

module Bundler
  class Index
    include Enumerable

    def self.build
      i = new
      yield i
      i
    end

    attr_reader :specs, :all_specs, :sources
    protected :specs, :all_specs

    RUBY = "ruby".freeze
    NULL = "\0".freeze

    def initialize
      @sources = []
      @cache = {}
      @specs = Hash.new {|h, k| h[k] = {} }
      @all_specs = Hash.new {|h, k| h[k] = EMPTY_SEARCH }
    end

    def initialize_copy(o)
      @sources = o.sources.dup
      @cache = {}
      @specs = Hash.new {|h, k| h[k] = {} }
      @all_specs = Hash.new {|h, k| h[k] = EMPTY_SEARCH }

      o.specs.each do |name, hash|
        @specs[name] = hash.dup
      end
      o.all_specs.each do |name, array|
        @all_specs[name] = array.dup
      end
    end

    def inspect
      "#<#{self.class}:0x#{object_id} sources=#{sources.map(&:inspect)} specs.size=#{specs.size}>"
    end

    def empty?
      each { return false }
      true
    end

    def search_all(name)
      all_matches = local_search(name) + @all_specs[name]
      @sources.each do |source|
        all_matches.concat(source.search_all(name))
      end
      all_matches
    end

    # Search this index's specs, and any source indexes that this index knows
    # about, returning all of the results.
    def search(query, base = nil)
      results = local_search(query, base)
      seen = results.map(&:full_name).to_set

      @sources.each do |source|
        source.search(query, base).each do |spec|
          results << spec if seen.add?(spec.full_name)
        end
      end

      results.sort_by do |s|
        platform_string = s.platform.to_s
        [s.version, platform_string == RUBY ? NULL : platform_string]
      end
    end

    def local_search(query, base = nil)
      case query
      when Gem::Specification, RemoteSpecification, LazySpecification, EndpointSpecification then search_by_spec(query)
      when String then specs_by_name(query)
      when Gem::Dependency then search_by_dependency(query, base)
      when DepProxy then search_by_dependency(query.dep, base)
      else
        raise "You can't search for a #{query.inspect}."
      end
    end

    alias_method :[], :search

    def <<(spec)
      @specs[spec.name][spec.full_name] = spec
      spec
    end

    def each(&blk)
      return enum_for(:each) unless blk
      specs.values.each do |spec_sets|
        spec_sets.values.each(&blk)
      end
      sources.each {|s| s.each(&blk) }
    end

    # returns a list of the dependencies
    def unmet_dependency_names
      names = dependency_names
      names.delete_if {|n| n == "bundler" }
      names.select {|n| search(n).empty? }
    end

    def dependency_names
      names = []
      each {|s| names.concat(s.dependencies.map(&:name)) }
      names.uniq
    end

    def use(other, override_dupes = false)
      return unless other
      other.each do |s|
        if (dupes = search_by_spec(s)) && !dupes.empty?
          # safe to << since it's a new array when it has contents
          @all_specs[s.name] = dupes << s
          next unless override_dupes
        end
        self << s
      end
      self
    end

    def size
      @sources.inject(@specs.size) do |size, source|
        size += source.size
      end
    end

    def ==(other)
      all? do |spec|
        other_spec = other[spec].first
        other_spec && dependencies_eql?(spec, other_spec) && spec.source == other_spec.source
      end
    end

    def dependencies_eql?(spec, other_spec)
      deps       = spec.dependencies.select {|d| d.type != :development }
      other_deps = other_spec.dependencies.select {|d| d.type != :development }
      Set.new(deps) == Set.new(other_deps)
    end

    def add_source(index)
      raise ArgumentError, "Source must be an index, not #{index.class}" unless index.is_a?(Index)
      @sources << index
      @sources.uniq! # need to use uniq! here instead of checking for the item before adding
    end

  private

    def specs_by_name(name)
      @specs[name].values
    end

    def search_by_dependency(dependency, base = nil)
      @cache[base || false] ||= {}
      @cache[base || false][dependency] ||= begin
        specs = specs_by_name(dependency.name)
        specs += base if base
        found = specs.select do |spec|
          next true if spec.source.is_a?(Source::Gemspec)
          if base # allow all platforms when searching from a lockfile
            dependency.matches_spec?(spec)
          else
            dependency.matches_spec?(spec) && Gem::Platform.match(spec.platform)
          end
        end

        wants_prerelease = dependency.requirement.prerelease?
        only_prerelease  = specs.all? {|spec| spec.version.prerelease? }

        unless wants_prerelease || only_prerelease
          found.reject! {|spec| spec.version.prerelease? }
        end

        found
      end
    end

    EMPTY_SEARCH = [].freeze

    def search_by_spec(spec)
      spec = @specs[spec.name][spec.full_name]
      spec ? [spec] : EMPTY_SEARCH
    end
  end
end
