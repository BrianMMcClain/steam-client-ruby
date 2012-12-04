module SteamClient
  class Profile
    
    attr_reader :steamID64, :onlineState, :avatarIcon, :avatarMedium, :avatarFull, :customURL, :hoursPlayed2Wk, :location, :realname
    
    def initalize
      
    end
    
    def self.from_xml(xml)
      
    end
  end
end