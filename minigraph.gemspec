# frozen_string_literal: true

require_relative 'lib/minigraph/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruby-minigraph'
  spec.version       = Minigraph::VERSION
  spec.authors       = ['kojix2']
  spec.email         = ['2xijok@gmail.com']

  spec.summary       = 'Ruby bindings for minigraph'
  spec.description   = 'Ruby bindings for minigraph (bioinformatics)'
  spec.homepage      = 'https://github.com/kojix2/ruby-minigraph'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.5'

  spec.files         = Dir['*.{md,txt}', '{lib}/**/*', 'vendor/libminigraph.{so,dylib}']
  spec.require_paths = ['lib']

  spec.add_dependency 'ffi'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'tty-command'
end
