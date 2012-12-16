require 'spec_helper'

describe SteamClient::Client do 
  
  it "should instantiate" do
    client = SteamClient::Client.new("XXXXXXXXX")
    client.api_key.should == "XXXXXXXXX"
  end
  
  it "should get a profile by name" do
  	VCR.use_cassette('steam_profile') do
    	profile = @client.find_profile_by_name("robinwalker")
    	profile.class.should be SteamClient::Profile
    	profile.steamID64.should match "76561197960435530"
    	profile.customURL.should match "robinwalker"
    end
  end

  it "should get a profile by id" do
  	VCR.use_cassette('steam_profile_id') do
  		profile = @client.find_profile_by_id("76561197960435530")
  		profile.class.should == SteamClient::Profile
  		profile.steamID64.should match "76561197960435530"
  		profile.customURL.should match "robinwalker"
  	end
  end

  it "should throw an error on an invalid ID" do
  	VCR.use_cassette('steam_invalid_ID') do
  		lambda {@client.find_profile_by_id("1")}.should raise_error SteamClient::Error::ProfileNotFound
  	end
  end

end