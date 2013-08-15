# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-jawbone/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ruthie Nachmany", "Max Jacobson", "Sarah Duve"]
  gem.email         = ["ruthie.nachmany@flatironschool.com", "maxwell.jacobson@flatironschool.com", "sarah.duve@flatironschool.com"]
  gem.description   = %q{OmniAuth strategy for Jawbone.}
  gem.summary       = %q{OmniAuth strategy for Jawbone.}
  gem.homepage      = "https://github.com/ruthienachmany/omniauth-jawbone"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-jawbone"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::Jawbone::VERSION

  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'omniauth-oauth2', '~> 1.0'
  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
end
