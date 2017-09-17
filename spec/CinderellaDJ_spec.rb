require 'spec_helper'
require_relative '../src/CinderellaDJ'
describe CinderellaDJ do
	before :each do
		@dj = CinderellaDJ.new "cool", JSON.parse(File.read( File.expand_path(File.dirname(__FILE__))+"/test0.json"), object_class: OpenStruct)
		@dj2 = CinderellaDJ.new "hot", JSON.parse(File.read( File.expand_path(File.dirname(__FILE__))+"/test0.json"), object_class: OpenStruct)
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
end
