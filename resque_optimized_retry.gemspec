# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'resque_optimized_retry/version'

Gem::Specification.new do |spec|
  spec.name          = "resque_optimized_retry"
  spec.version       = ResqueOptimizedRetry::VERSION
  spec.authors       = ["Rodrigo Fontoura"]
  spec.email         = ["rodrigo.fontoura@dito.com.br"]
  spec.description   = %q{Gem para dar retry de forma otimizada nos jobs que falharam do Resque}
  spec.summary       = %q{Gem para dar retry de forma otimizada nos jobs que falharam do Resque}
  spec.homepage      = ""
  spec.license       = ""

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
