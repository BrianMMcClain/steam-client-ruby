require_relative '../lib/steam-client'

require 'webmock/rspec'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

RSpec.configure do |config|
	config.before(:all) do
		VCR.use_cassette('steam_profile_id') do
			@client = SteamClient::Client.new("XXXXXXXXX")
			@profile = @client.find_profile_by_id("76561197960435530")
		end
	end
end