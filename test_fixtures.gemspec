# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'test_fixtures/version'

Gem::Specification.new do |spec|
  spec.name          = 'test_fixtures'
  spec.version       = TestFixtures::VERSION
  spec.authors       = ['Richard Hauswald']
  spec.email         = %w(richard.hauswald@googlemail.com)
  spec.description   = %q{Provides a simple api to get paths to a tests fixture directory based on a convention using the test case files name and directory.}
  spec.summary       = %q{Provides a simple api to get paths to a tests fixture directory.}
  spec.homepage      = 'https://github.com/staenker/test_fixtures'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
