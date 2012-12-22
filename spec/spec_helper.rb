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
      api_key = ENV['STEAM_CLIENT_API_KEY'] || "XXXXXXXXX"
			@client = SteamClient::Client.new(api_key)
			@profile = @client.find_profile_by_id("76561197960435530")
		end
	end
end