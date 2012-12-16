require 'spec_helper'

describe SteamClient::Profile do 

	it "Should be parsed from XML" do
		VCR.use_cassette('steam_profile') do
			profile = @client.find_profile_by_name("robinwalker")

	    	profile.class.should be SteamClient::Profile
	    	profile.steamID64.should match "76561197960435530"
	      	profile.avatarIcon.should match "http://media.steampowered.com/steamcommunity/public/images/avatars/f1/f1dd60a188883caf82d0cbfccfe6aba0af1732d4.jpg"
	      	profile.avatarMedium.should match "http://media.steampowered.com/steamcommunity/public/images/avatars/f1/f1dd60a188883caf82d0cbfccfe6aba0af1732d4_medium.jpg"
	      	profile.avatarFull.should match "http://media.steampowered.com/steamcommunity/public/images/avatars/f1/f1dd60a188883caf82d0cbfccfe6aba0af1732d4_full.jpg"
	      	profile.customURL.should match "robinwalker"
	      	profile.hoursPlayed2Wk.should eq(77.7)
	      	profile.location.should match "Bellevue, Washington, United States"
	      	profile.realname.should match "Robin Walker"
	      	profile.onlineState.should be SteamClient::OnlineState::OFFLINE
	    end
	end
end