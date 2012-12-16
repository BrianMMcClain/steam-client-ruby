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

  it "should get a profile's friend list" do
      VCR.use_cassette('steam_profile_friends') do
        friends = @client.get_friends_from_profile(@profile)
        friends.count.should eq(269)
        friends.empty?.should_not be true
        @profile.friends.empty?.should_not be true
      end
  end

  it "should get a profiles game list" do
    VCR.use_cassette('steam_profile_game_list') do
      games = @client.get_games_from_profile(@profile)
      games.count.should eq(2046)
      games.empty?.should_not be true
      @profile.games.empty?.should_not be true
    end
  end
end