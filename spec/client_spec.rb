require 'spec_helper'

describe SteamClient::Client do 
  
  it "should instantiate" do
    client = SteamClient::Client.new("XXXXXXXXX")
    client.api_key.should == "XXXXXXXXX"
  end
  
  it "should get a profile by name" do
  	VCR.use_cassette('steam_profile') do
    	profile = @client.find_profile_by_name("robinwalker")
    	profile.class.should == SteamClient::Profile
    end
  end

end