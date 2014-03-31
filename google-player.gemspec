# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'google-play/version'

Gem::Specification.new do |spec|
  spec.name          = 'google-player'
  spec.version       = GooglePlay::VERSION
  spec.authors       = ['mako2x']
  spec.email         = ['arekara3nen@gmail.com']
  spec.description   = %q{Ruby gem for fetching app info and reviews from Google Play.}
  spec.summary       = %q{Fetchs app info and reviews from Google Play.}
  spec.homepage      = 'https://github.com/mako2x/google-player'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'nokogiri', '>=1.5.6'
  spec.add_dependency 'hashie'
  spec.add_dependency 'httpclient'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
