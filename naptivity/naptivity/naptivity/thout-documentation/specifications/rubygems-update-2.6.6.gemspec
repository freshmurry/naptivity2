# -*- encoding: utf-8 -*-
# stub: rubygems-update 2.6.6 ruby hide_lib_for_update

Gem::Specification.new do |s|
  s.name = "rubygems-update".freeze
  s.version = "2.6.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["hide_lib_for_update".freeze]
  s.authors = ["Jim Weirich".freeze, "Chad Fowler".freeze, "Eric Hodel".freeze]
  s.date = "2016-06-22"
  s.description = "RubyGems is a package management framework for Ruby.\n\nThis gem is an update for the RubyGems software. You must have an\ninstallation of RubyGems before this update can be applied.\n\nSee Gem for information on RubyGems (or `ri Gem`)\n\nTo upgrade to the latest RubyGems, run:\n\n  $ gem update --system  # you might need to be an administrator or root\n\nSee UPGRADING.rdoc for more details and alternative instructions.\n\n-----\n\nIf you don't have RubyGems installed, you can still do it manually:\n\n* Download from: https://rubygems.org/pages/download, unpack, and cd there\n* OR clone this repository and cd there\n* Install with: ruby setup.rb  # you may need admin/root privilege\n\nFor more details and other options, see:\n\n  ruby setup.rb --help".freeze
  s.email = ["rubygems-developers@rubyforge.org".freeze]
  s.executables = ["update_rubygems".freeze]
  s.extra_rdoc_files = ["CODE_OF_CONDUCT.md".freeze, "CONTRIBUTING.rdoc".freeze, "CVE-2013-4287.txt".freeze, "CVE-2013-4363.txt".freeze, "CVE-2015-3900.txt".freeze, "History.txt".freeze, "LICENSE.txt".freeze, "MAINTAINERS.txt".freeze, "MIT.txt".freeze, "Manifest.txt".freeze, "POLICIES.rdoc".freeze, "README.rdoc".freeze, "UPGRADING.rdoc".freeze, "bundler/CHANGELOG.md".freeze, "bundler/CODE_OF_CONDUCT.md".freeze, "bundler/CONTRIBUTING.md".freeze, "bundler/DEVELOPMENT.md".freeze, "bundler/ISSUES.md".freeze, "bundler/LICENSE.md".freeze, "bundler/README.md".freeze, "bundler/man/index.txt".freeze, "hide_lib_for_update/note.txt".freeze]
  s.files = ["CODE_OF_CONDUCT.md".freeze, "CONTRIBUTING.rdoc".freeze, "CVE-2013-4287.txt".freeze, "CVE-2013-4363.txt".freeze, "CVE-2015-3900.txt".freeze, "History.txt".freeze, "LICENSE.txt".freeze, "MAINTAINERS.txt".freeze, "MIT.txt".freeze, "Manifest.txt".freeze, "POLICIES.rdoc".freeze, "README.rdoc".freeze, "UPGRADING.rdoc".freeze, "bin/update_rubygems".freeze, "bundler/CHANGELOG.md".freeze, "bundler/CODE_OF_CONDUCT.md".freeze, "bundler/CONTRIBUTING.md".freeze, "bundler/DEVELOPMENT.md".freeze, "bundler/ISSUES.md".freeze, "bundler/LICENSE.md".freeze, "bundler/README.md".freeze, "bundler/man/index.txt".freeze, "hide_lib_for_update/note.txt".freeze]
  s.homepage = "https://rubygems.org".freeze
  s.licenses = ["Ruby".freeze, "MIT".freeze]
  s.rdoc_options = ["--main".freeze, "README.rdoc".freeze, "--title=RubyGems Update Documentation".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7".freeze)
  s.rubygems_version = "2.6.4".freeze
  s.summary = "RubyGems is a package management framework for Ruby".freeze

  s.installed_by_version = "2.6.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<builder>.freeze, ["~> 2.1"])
      s.add_development_dependency(%q<hoe-seattlerb>.freeze, ["~> 1.2"])
      s.add_development_dependency(%q<rdoc>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<ZenTest>.freeze, ["~> 4.5"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.5"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 4.0"])
      s.add_development_dependency(%q<hoe>.freeze, ["~> 3.15"])
    else
      s.add_dependency(%q<builder>.freeze, ["~> 2.1"])
      s.add_dependency(%q<hoe-seattlerb>.freeze, ["~> 1.2"])
      s.add_dependency(%q<rdoc>.freeze, ["~> 3.0"])
      s.add_dependency(%q<ZenTest>.freeze, ["~> 4.5"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.5"])
      s.add_dependency(%q<minitest>.freeze, ["~> 4.0"])
      s.add_dependency(%q<hoe>.freeze, ["~> 3.15"])
    end
  else
    s.add_dependency(%q<builder>.freeze, ["~> 2.1"])
    s.add_dependency(%q<hoe-seattlerb>.freeze, ["~> 1.2"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 3.0"])
    s.add_dependency(%q<ZenTest>.freeze, ["~> 4.5"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.5"])
    s.add_dependency(%q<minitest>.freeze, ["~> 4.0"])
    s.add_dependency(%q<hoe>.freeze, ["~> 3.15"])
  end
end
