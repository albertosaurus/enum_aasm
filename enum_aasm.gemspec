# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'enum_aasm/version'

Gem::Specification.new do |spec|
  spec.name          = "enum_aasm"
  spec.version       = EnumAasm::VERSION
  spec.authors       = ["Arthur Shagall"]
  spec.email         = ["arthur.shagall@gmail.com"]
  spec.description   = %q{This gem patches AASM to use PowerEnum enums for states.}
  spec.summary       = %q{Use PowerEnum enums for AASM states.}
  spec.homepage      = "https://github.com/albertosaurus/enum_aasm"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'

  spec.add_dependency 'aasm'
  spec.add_dependency 'power_enum', '~> 2.0'
end
