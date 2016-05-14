# -*- encoding: utf-8 -*-
# stub: cancancan 1.13.1 ruby lib

Gem::Specification.new do |s|
  s.name = "cancancan"
  s.version = "1.13.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Bryan Rite", "Ryan Bates", "Richard Wilson"]
  s.date = "2016-05-14"
  s.description = "Continuation of the simple authorization solution for Rails which is decoupled from user roles. All permissions are stored in a single location."
  s.email = "r.crawfordwilson@gmail.com"
  s.files = [".gitignore", ".rspec", ".travis.yml", "Appraisals", "CHANGELOG.rdoc", "CONTRIBUTING.md", "Gemfile", "LICENSE", "README.md", "Rakefile", "cancancan.gemspec", "gemfiles/activerecord_3.2.gemfile", "gemfiles/activerecord_4.0.gemfile", "gemfiles/activerecord_4.1.gemfile", "gemfiles/activerecord_4.2.gemfile", "gemfiles/activerecord_5.0.gemfile", "gemfiles/mongoid_2.x.gemfile", "gemfiles/sequel_3.x.gemfile", "init.rb", "lib/cancan.rb", "lib/cancan/ability.rb", "lib/cancan/controller_additions.rb", "lib/cancan/controller_resource.rb", "lib/cancan/exceptions.rb", "lib/cancan/inherited_resource.rb", "lib/cancan/matchers.rb", "lib/cancan/model_adapters/abstract_adapter.rb", "lib/cancan/model_adapters/active_record_3_adapter.rb", "lib/cancan/model_adapters/active_record_4_adapter.rb", "lib/cancan/model_adapters/active_record_5_adapter.rb", "lib/cancan/model_adapters/active_record_adapter.rb", "lib/cancan/model_adapters/default_adapter.rb", "lib/cancan/model_adapters/mongoid_adapter.rb", "lib/cancan/model_adapters/sequel_adapter.rb", "lib/cancan/model_additions.rb", "lib/cancan/rule.rb", "lib/cancan/version.rb", "lib/cancancan.rb", "lib/generators/cancan/ability/USAGE", "lib/generators/cancan/ability/ability_generator.rb", "lib/generators/cancan/ability/templates/ability.rb", "spec/README.rdoc", "spec/cancan/ability_spec.rb", "spec/cancan/controller_additions_spec.rb", "spec/cancan/controller_resource_spec.rb", "spec/cancan/exceptions_spec.rb", "spec/cancan/inherited_resource_spec.rb", "spec/cancan/matchers_spec.rb", "spec/cancan/model_adapters/active_record_4_adapter_spec.rb", "spec/cancan/model_adapters/active_record_adapter_spec.rb", "spec/cancan/model_adapters/default_adapter_spec.rb", "spec/cancan/model_adapters/mongoid_adapter_spec.rb", "spec/cancan/model_adapters/sequel_adapter_spec.rb", "spec/cancan/rule_spec.rb", "spec/matchers.rb", "spec/spec.opts", "spec/spec_helper.rb", "spec/support/ability.rb"]
  s.homepage = "https://github.com/CanCanCommunity/cancancan"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0")
  s.rubygems_version = "2.5.1"
  s.summary = "Simple authorization solution for Rails."
  s.test_files = ["Appraisals", "gemfiles/activerecord_3.2.gemfile", "gemfiles/activerecord_4.0.gemfile", "gemfiles/activerecord_4.1.gemfile", "gemfiles/activerecord_4.2.gemfile", "gemfiles/activerecord_5.0.gemfile", "gemfiles/mongoid_2.x.gemfile", "gemfiles/sequel_3.x.gemfile", "spec/README.rdoc", "spec/cancan/ability_spec.rb", "spec/cancan/controller_additions_spec.rb", "spec/cancan/controller_resource_spec.rb", "spec/cancan/exceptions_spec.rb", "spec/cancan/inherited_resource_spec.rb", "spec/cancan/matchers_spec.rb", "spec/cancan/model_adapters/active_record_4_adapter_spec.rb", "spec/cancan/model_adapters/active_record_adapter_spec.rb", "spec/cancan/model_adapters/default_adapter_spec.rb", "spec/cancan/model_adapters/mongoid_adapter_spec.rb", "spec/cancan/model_adapters/sequel_adapter_spec.rb", "spec/cancan/rule_spec.rb", "spec/matchers.rb", "spec/spec.opts", "spec/spec_helper.rb", "spec/support/ability.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, ["~> 10.1.1"])
      s.add_development_dependency(%q<rspec>, ["~> 3.2.0"])
      s.add_development_dependency(%q<appraisal>, [">= 2.0.0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, ["~> 10.1.1"])
      s.add_dependency(%q<rspec>, ["~> 3.2.0"])
      s.add_dependency(%q<appraisal>, [">= 2.0.0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, ["~> 10.1.1"])
    s.add_dependency(%q<rspec>, ["~> 3.2.0"])
    s.add_dependency(%q<appraisal>, [">= 2.0.0"])
  end
end
