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
    	xml = get_with_retries url
    	return Profile.from_xml(xml)
    end

    def find_profile_by_id(id)
    	url = "http://steamcommunity.com/profiles/#{id}?xml=1"
    	xml = get_with_retries url
    	return Profile.from_xml(xml)
    end

    def get_friends_from_profile(profile)
        url = "http://steamcommunity.com/profiles/#{profile.steamID64}/friends?xml=1"
        xml = get_with_retries url
        hFriends = Crack::XML.parse xml
        friends = []
        hFriends['friendsList']['friends']['friend'].each do |friendID|
            friends << Profile.new(friendID)
        end
        profile.friends = friends
        return friends
    end

    def get_games_from_profile(profile)
        url = "http://steamcommunity.com/profiles/#{profile.steamID64}/games\?xml\=1"
        xml = get_with_retries url
        hGames = Crack::XML.parse xml
        games = []
        hGames['gamesList']['games']['game'].each do |game|
            games << Game.new(game)
        end
        profile.games = games
        return games
    end

    def get_with_retries(url, retries = 10)
        attempt = 0
        while attempt < retries
            begin
                resp = RestClient.get url
                return resp
            rescue RestClient::ServiceUnavailable
                attempt += 1
            end
        end

        throw new RestClient::ServiceUnavailable
    end
  end
end