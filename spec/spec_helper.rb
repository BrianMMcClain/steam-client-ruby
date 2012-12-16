require_relative '../lib/steam-client'

require 'webmock/rspec'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

RSpec.configure do |config|
	config.before(:all) do
		@client = SteamClient::Client.new("XXXXXXXXX")
	end
end