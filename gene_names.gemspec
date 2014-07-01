# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gene_names/version'

Gem::Specification.new do |spec|
  spec.name          = "gene_names"
  spec.version       = GeneNames::VERSION
  spec.authors       = ["Eric Harrison", "SmashTank Apps"]
  spec.email         = ["eharrison@smashtankapps.com"]
  spec.summary       = %q{Gem for access to genenames.org api}
  spec.description   = %q{}
  spec.homepage      = "http://github.com/smashtank/gene_names"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
