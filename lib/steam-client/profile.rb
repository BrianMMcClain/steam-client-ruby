require 'crack'
require 'json'

module SteamClient

  module Error
  	class ProfileNotFound < StandardError
  		def message
  			"The specified profile could not be found"
  		end
  	end
  end

  module OnlineState
  	ONLINE = "online",
  	OFFLINE = "offline"
  	UNKNOWN = "unknown"
  end

  class Profile
    
    attr_accessor :steamID, :steamID64, :onlineState, :avatarIcon, :avatarMedium, :avatarFull, :customURL, :hoursPlayed2Wk, :location, :realname, :friends, :games

    def initialize(steamID64 = nil)
      self.steamID64 = steamID64
      @friends = []
      @games = []
    end
    
    def self.from_json(json)
      p = JSON.parse(json)
      
      if p['response']['players'].empty?
        raise SteamClient::Error::ProfileNotFound
      end
      
      player = p['response']['players'].first
      
      profile = Profile.new
      profile.steamID = player['personaname']
      profile.steamID64 =player['steamid']
      profile.avatarIcon = player['avatar']
      profile.avatarMedium = player['avatarmedium']
      profile.avatarFull = player['avatarfull']
      profile.customURL = player['profileurl']
      profile.hoursPlayed2Wk = 0.0
      profile.location = "#{player['loccityid'] || ''} #{player['locstatecode'] || ''} #{player['loccountrycode']}".strip
      profile.realname = player['realname']
      profile.friends = []
      profile.games = []
      profile.onlineState = SteamClient::OnlineState::UNKNOWN
      
      return profile     
    end
    
    def self.from_xml(xml)
      p = Crack::XML.parse(xml)

      if p.has_key? 'response' and p['response'].has_key? 'error'
      	raise SteamClient::Error::ProfileNotFound
      end

      profile = Profile.new
      
      profile.steamID = p['profile']['steamID']
      profile.steamID64 = p['profile']['steamID64']
      profile.avatarIcon = p['profile']['avatarIcon']
      profile.avatarMedium = p['profile']['avatarMedium']
      profile.avatarFull = p['profile']['avatarFull']
      profile.customURL = p['profile']['customURL']
      profile.hoursPlayed2Wk = p['profile']['hoursPlayed2Wk'].to_f
      profile.location = p['profile']['location']
      profile.realname = p['profile']['realname']
      profile.friends = []
      profile.games = []

      case p['profile']['onlineState']
      when 'online'
      	profile.onlineState = SteamClient::OnlineState::ONLINE
      when 'offline'
      	profile.onlineState = SteamClient::OnlineState::OFFLINE
      else
      	profile.onlineState = SteamClient::OnlineState::UNKNOWN
      end
      return profile
    end
  end
end