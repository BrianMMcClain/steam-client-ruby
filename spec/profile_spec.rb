require 'spec_helper'

describe SteamClient::Profile do 

	it "Should be parsed from XML" do
		VCR.use_cassette('steam_profile') do
			profile = @client.find_profile_by_name("robinwalker")

	    	profile.class.should be SteamClient::Profile
	    	profile.steamID.should match "Robin"
	    	profile.steamID64.should match "76561197960435530"
	      	profile.avatarIcon.should match "http://media.steampowered.com/steamcommunity/public/images/avatars/f1/f1dd60a188883caf82d0cbfccfe6aba0af1732d4.jpg"
	      	profile.avatarMedium.should match "http://media.steampowered.com/steamcommunity/public/images/avatars/f1/f1dd60a188883caf82d0cbfccfe6aba0af1732d4_medium.jpg"
	      	profile.avatarFull.should match "http://media.steampowered.com/steamcommunity/public/images/avatars/f1/f1dd60a188883caf82d0cbfccfe6aba0af1732d4_full.jpg"
	      	profile.customURL.should match "robinwalker"
	      	profile.hoursPlayed2Wk.should eq(0.0)
	      	profile.location.should match "3961 WA US"
	      	profile.realname.should match "Robin Walker"
	      	profile.onlineState.should be SteamClient::OnlineState::UNKNOWN
	    end
	end

	it "should throw an error on an invalid ID" do
		VCR.use_cassette('steam_invalid_id') do
	  		lambda {@client.find_profile_by_id("1")}.should raise_error SteamClient::Error::ProfileNotFound
	  	end
  	end
end