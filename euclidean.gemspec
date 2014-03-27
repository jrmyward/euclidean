# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'euclidean/version'

Gem::Specification.new do |spec|
  spec.name          = "euclidean"
  spec.version       = Euclidean::VERSION
  spec.authors       = ["Jeremy Ward"]
  spec.email         = ["jeremy.ward@digital-ocd.com"]
  spec.summary       = %q{Basic Geometric primitives and algoritms for Ruby}
  spec.description   = %q{Basic Geometric primitives and algoritms for Ruby}
  spec.homepage      = "https://github.com/jrmyward/euclidean"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
end
