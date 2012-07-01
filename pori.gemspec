# -*- encoding: utf-8 -*-
require File.expand_path('../lib/pori/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors        = ["Akira Maeda"]
  gem.email          = ["glidenote@gmail.com"]
  gem.summary        = %q{A command line tool for Bitbucket to create, delete private repositories.(only git)}
  gem.homepage       = "http://github.com/glidenote/pori/"

  gem.files          = `git ls-files`.split($\)
  gem.executables    = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files     = gem.files.grep(%r{^(test|spec|features)/})
  gem.name           = 'pori'
  gem.require_paths  = ["lib"]
  gem.version        = Pori::VERSION

  gem.add_dependency 'pit'
  gem.add_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
