require 'rest-client'
require 'crack'

module SteamClient
  class Client
    
    attr_reader :api_key
  
    def initialize(api_key = nil)
      @api_key = api_key
    end

    def find_profile_by_name(name)
    	url = "http://steamcommunity.com/id/#{name}?xml=1"
    	xml = RestClient.get url
    	return Profile.from_xml(xml)
    end

    def find_profile_by_id(id)
    	url = "http://steamcommunity.com/profiles/#{id}?xml=1"
    	xml = RestClient.get url
    	return Profile.from_xml(xml)
    end

    def get_friends_from_profile(profile)
        url = "http://steamcommunity.com/profiles/#{profile.steamID64}/friends?xml=1"
        xml = RestClient.get url
        hFriends = Crack::XML.parse xml
        friends = []
        hFriends['friendsList']['friends']['friend'].each do |friendID|
            friends << Profile.new(friendID)
        end
        profile.friends = friends
        return friends
    end
  end
end