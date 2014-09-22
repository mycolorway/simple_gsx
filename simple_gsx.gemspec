# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_gsx/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_gsx"
  spec.version       = SimpleGsx::VERSION
  spec.authors       = ["zchar"]
  spec.email         = ["zchar@mycolorway.com"]
  spec.summary       = %q{Apple GSX API Library}
  spec.description   = %q{A Ruby library for communicating with Apple's GSX restful API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"

  spec.add_dependency 'rest-client', '~> 1.6'
  spec.add_dependency 'json', '~> 1.8'
end
