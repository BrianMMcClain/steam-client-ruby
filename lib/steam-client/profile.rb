require 'crack'

module SteamClient

  module OnlineState
  	ONLINE = "online",
  	OFFLINE = "offline"
  	UNKNOWN = "unknown"
  end

  class Profile
    
    attr_accessor :steamID64, :onlineState, :avatarIcon, :avatarMedium, :avatarFull, :customURL, :hoursPlayed2Wk, :location, :realname
    
    def initalize
      
    end
    
    def self.from_xml(xml)
      p = Crack::XML.parse(xml)
      profile = Profile.new
      
      profile.steamID64 = p['profile']['steamID64']
      profile.avatarIcon = p['profile']['avatarIcon']
      profile.avatarMedium = p['profile']['avatarMedium']
      profile.avatarFull = p['profile']['avatarFull']
      profile.customURL = p['profile']['customURL']
      profile.hoursPlayed2Wk = p['profile']['hoursPlayed2Wk'].to_f
      profile.location = p['profile']['location']
      profile.realname = p['profile']['realname']

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