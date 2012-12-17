# -*- encoding: utf-8 -*-
require File.expand_path('../lib/steam-client/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Brian McClain"]
  gem.email         = ["brianmmcclain@gmail.com"]
  gem.description   = %q{Steam Client}
  gem.summary       = gem.summary
  gem.homepage      = "https://github.com/BrianMMcClain/steam-client-ruby"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "steam-client"
  gem.require_paths = ["lib"]
  gem.version       = SteamClient::VERSION

  gem.add_dependency 'rest-client', '1.6.7'
  gem.add_dependency 'crack', '0.3.1'
end