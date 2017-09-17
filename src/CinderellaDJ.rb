#All day, all night, don't stop music!
class CinderellaDJ
	def initialize(starting_tag, songs)
		@starting_tag = starting_tag
		@songs = songs
		@backlog = []
	end

	def getSong
		criteria = @songs.select do |song|
			song.tags.send(@starting_tag) == 1
		end
		criteria.reject! do |song|
			@backlog.include?(song.identifier)
		end
		cur_song = nil
		loop do
			if criteria.length > 0
				cur_song = criteria.sample
			else
				cur_song = @songs.sample
			end
			break if @backlog.length == 0 || !@backlog.include?(cur_song.identifier)
		end
		@backlog.unshift(cur_song.identifier)
		if @backlog.length >= @songs.length
			@backlog.pop
		end
		return cur_song
	end
end
