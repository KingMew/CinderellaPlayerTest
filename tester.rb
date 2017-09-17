#!/usr/bin/ruby
require "json"
puts "Cinderella Player Test\n================\n\n"
if !File.file?("Cinderella.json")
	puts "You need to create a Cinderella.json file with channel data"
	exit
end
channel = JSON.parse(File.read("Cinderella.json"), object_class: OpenStruct).channels[0]
filename = channel.file
if !File.file?(filename)
	puts "You need to create a #{filename} file with song data"
	exit
end
songs = JSON.parse(File.read(filename), object_class: OpenStruct)

backlog = []
current_song = nil

puts channel.name
puts channel.description
puts
puts "What mood are you in?"
channel.tags.each_with_index do |tag,i|
	number = (i+1).to_s.rjust(Math.log10(channel.tags.length).floor+1,"0")
	puts "#{number}. #{tag.label}"
end
a = 0
while a < 1 or a > channel.tags.length do
	a = gets.chomp.to_i
end
selected_tag = channel.tags[a-1]
puts "#{selected_tag.label} it is!"

def getSong(selected_tag,songs,backlog)
	criteria = songs.select do |song|
		if song.tags.send(selected_tag.name)
			if selected_tag.type == "float"
				if song.tags.send(selected_tag.name) > 0.5
					true
				end
			elsif selected_tag.type == "bool"
				song.tags.send(selected_tag.name)>0
			end
		else
			false
		end
	end
	criteria.reject! do |song|
		backlog.include?(song.identifier)
	end
	cur_song = nil
	loop do
		if criteria.length > 0
			cur_song = criteria.sample
		else
			cur_song = songs.sample
		end
		break if backlog.length == 0 || !backlog.include?(cur_song.identifier)
	end
	backlog.unshift(cur_song.identifier)
	return cur_song
end

loop do
	current_song = getSong(selected_tag,songs,backlog)
	puts "Now Playing: #{current_song.title}"
	`mplayer -endpos 00:00:10 "music/#{current_song.filename}" -af volume=-12 >/dev/null 2>&1`
end
