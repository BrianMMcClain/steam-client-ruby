module SteamClient
	class Game
		attr_accessor :id, :name, :logo

		def initialize(opts = {})
			@id = opts['appID']
			@name = opts['name']
			@logo = opts['logo']
		end 
	end
end