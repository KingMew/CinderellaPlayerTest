#All day, all night, don't stop music!
class CinderellaDJ
	def initialize(starting_tag, songs)
		@starting_tag = starting_tag
		@songs = songs
		@backlog = []
		@tag_tolerance = 1.0
		@target_tag = starting_tag
	end

	def generateCriteria
		criteria = @songs.select do |song|
			song.tags.send(@target_tag) >= @tag_tolerance
		end
		criteria.reject! do |song|
			@backlog.include?(song.identifier)
		end
		return criteria
	end

	def getSong
		criteria = generateCriteria
		cur_song = nil
		loop do
			if criteria.length > 0
				cur_song = criteria.sample
				@tag_tolerance -= rand * rand * 0.2
			else
				@tag_tolerance /= 2.0
				new_criteria = generateCriteria
				if generateCriteria.length > 0
					cur_song = new_criteria.sample
					tag_switch = (cur_song.tags.marshal_dump.reject { |tag| tag == @target_tag }).to_a.sample[0]
					if cur_song.tags.send(tag_switch) > cur_song.tags.send(@target_tag)
						@target_tag = tag_switch
						@tag_tolerance = 1
					end
				end
			end
			if cur_song != nil
				break if @backlog.length == 0 || !@backlog.include?(cur_song.identifier)
			end
		end
		@backlog.unshift(cur_song.identifier)
		if @backlog.length >= @songs.length
			@backlog.pop
		end
		return cur_song
	end
end
