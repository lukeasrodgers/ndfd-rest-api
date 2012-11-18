# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ndfdrestapi/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Luke Rodgers"]
  gem.email         = ["lukeasrodgers@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ndfdrestapi"
  gem.require_paths = ["lib"]
  gem.version       = Ndfdrestapi::VERSION

  gem.add_runtime_dependency "nori", "~> 1.1.3"
end
