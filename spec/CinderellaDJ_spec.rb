require 'spec_helper'
require_relative '../src/CinderellaDJ'
describe CinderellaDJ do
	before :each do
		@dj = CinderellaDJ.new "cool", JSON.parse(File.read( File.expand_path(File.dirname(__FILE__))+"/test0.json"), object_class: OpenStruct)
		@dj2 = CinderellaDJ.new "hot", JSON.parse(File.read( File.expand_path(File.dirname(__FILE__))+"/test0.json"), object_class: OpenStruct)

		@dj3 = CinderellaDJ.new "cute", JSON.parse(File.read( File.expand_path(File.dirname(__FILE__))+"/test1.json"), object_class: OpenStruct)
	end

	describe "#new" do
		it "returns a CinderellaDJ object" do
			expect(@dj).to be_an_instance_of CinderellaDJ
			expect(@dj2).to be_an_instance_of CinderellaDJ
		end
	end

	describe "#getSong @ test0.json" do
		it "returns the appropriate first song" do
			expect(@dj.getSong.title).to eq "Cool song"
			expect(@dj2.getSong.title).to eq "Hot song"
		end
		it "returns the appropriate second song" do
			@dj.getSong
			@dj2.getSong
			expect(@dj.getSong.title).to eq "Hot song"
			expect(@dj2.getSong.title).to eq "Cool song"
		end
		it "returns the appropriate third song (and doesn't run out of songs)" do
			@dj.getSong
			@dj2.getSong
			@dj.getSong
			@dj2.getSong
			expect(@dj.getSong.title).to eq "Cool song"
			expect(@dj2.getSong.title).to eq "Hot song"
		end
	end

	describe "#getSong @ test1.json" do
		it "returns the appropriate first song" do
			#Although there are technically multiple songs for this DJ to choose, this
			#test data is configured so the elligible songs both have similar names
			expect(@dj3.getSong.title).to eq "Cute song"
		end
		it "returns the appropriate second song and they are different" do
			song1 = @dj3.getSong
			song2 = @dj3.getSong
			expect(song2.title).to eq "Cute song"
			expect(song1.artist).not_to eq(song2.artist)
		end
		it "returns the appropriate third song" do
			song1 = @dj3.getSong
			song2 = @dj3.getSong
			expect(@dj3.getSong.title).to eq "Passion-cute song"
		end
	end
end
