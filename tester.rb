#!/usr/bin/ruby
puts "Cinderella Player Test"
if !File.file? "Playlist.json"
	puts "You need to create a Playlist.json file with song data"
	exit
end
