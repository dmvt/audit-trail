# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'audit/trail/version'

Gem::Specification.new do |spec|
  spec.name          = "audit-trail"
  spec.version       = Audit::Trail::VERSION
  spec.authors       = ["Dan Matthews"]
  spec.email         = ["dan@bluefoc.us"]
  spec.summary       = %q{A Ruby gem for creating and searching audit logs}
  spec.description   = %q{Requires only no-sql storage}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '~> 2.1'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
