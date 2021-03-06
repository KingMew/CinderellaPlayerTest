require "json"
class CinderellaChannel
	def initialize(identifier,config_location)
		@identifier = identifier
		@config_location = config_location
		if File.file?(@config_location+"/Cinderella.json")
			cinderella_data = JSON.parse(File.read(config_location+"/Cinderella.json"), object_class: OpenStruct)
			channels = cinderella_data.channels.select do |channel|
				channel.identifier == identifier
			end
			if channels.length > 0
				@channel_data = channels[0]
			else
				@identifier = nil
			end
		else
			@identifier = nil
		end
	end

	def identifier
		return @identifier
	end

	def name
		return @channel_data.name
	end
	def description
		return @channel_data.description
	end
	def tags
		return @channel_data.tags
	end

	def getSong(tag)
		songdata = JSON.parse(File.read(@config_location+"/"+@channel_data.file), object_class: OpenStruct)
		songdata.select! do |song|
			song.tags.send(tag) == 1
		end
		return songdata[0]
	end
end
