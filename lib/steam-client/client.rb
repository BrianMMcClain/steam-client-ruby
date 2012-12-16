require 'rest-client'

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
  end
end