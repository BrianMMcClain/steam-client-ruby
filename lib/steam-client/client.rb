require 'rest-client'
require 'crack'
require 'json'

module SteamClient
  class Client
    
    attr_reader :api_key
  
    def initialize(api_key = nil)
      @api_key = api_key
    end
    
    def find_steam_id_by_name(name)
      if not @api_key.nil?
        url = "http://api.steampowered.com/ISteamUser/ResolveVanityURL/v0001/?key=#{@api_key}&vanityurl=#{name}"
        data = get_with_retries url
        j = JSON.parse(data)
        return j['response']['steamid']
      end
    end

    def find_profile_by_name(name)
      id = find_steam_id_by_name(name)
    	return find_profile_by_id(id)
    end

    def find_profile_by_id(id)
      url = ""
      if not @api_key.nil?
        url = "http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=#{@api_key}&steamids=#{id}"
        data = get_with_retries url
        return Profile.from_json(data)
      else
    	  url = "http://steamcommunity.com/profiles/#{id}?xml=1"
    	  xml = get_with_retries url
    	  return Profile.from_xml(xml)
      end
    end

    def get_friends_from_profile(profile)
      friends = get_friends_from_id(profile.steamID64)
      profile.friends = friends
      return friends
    end
    
    def get_friends_from_id(id)
      url = ""
      if not @api_key.nil?
        url = "http://api.steampowered.com/ISteamUser/GetFriendList/v0001/?key=#{@api_key}&steamid=#{id}&relationship=friend"
        data = get_with_retries url
        jFriends = JSON.parse(data)
        friends = []
        jFriends['friendslist']['friends'].each do |friend|
          friends << Profile.new(friend['steamid'])
        end
        return friends
      else
        url = "http://steamcommunity.com/profiles/#{id}/friends?xml=1"
        xml = get_with_retries url
        hFriends = Crack::XML.parse xml
        friends = []
        hFriends['friendsList']['friends']['friend'].each do |friendID|
            friends << Profile.new(friendID)
        end
        return friends
      end
    end
    
    def get_games_from_profile(profile)
      games = get_games_from_id(profile.steamID64)
      profile.games = games
      return games
    end
    
    def get_games_from_id(id)
      url = "http://steamcommunity.com/profiles/#{id}/games\?tab=all&xml\=1"
      xml = get_with_retries url
      hGames = Crack::XML.parse xml
      games = []
      hGames['gamesList']['games']['game'].each do |game|
          games << Game.new(game)
      end
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
                sleep 0.5
            end
        end

        raise RestClient::ServiceUnavailable
    end
  end
end