# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'htmon/icinga/version'

Gem::Specification.new do |spec|
  spec.name          = "htmon-icinga"
  spec.version       = Htmon::Icinga::VERSION
  spec.authors       = ["Tim Foerster"]
  spec.email         = ["github@mailserver.1n3t.de"]

  spec.summary       = %q{Htmon Icinga2 Client}
  spec.homepage      = "https://github.com/timmyArch/htmon-icinga"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "redis"
  spec.add_dependency "activesupport"
end
