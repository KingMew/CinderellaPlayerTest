require 'spec_helper'
require_relative '../src/CinderellaChannel'
describe CinderellaChannel do
	before :each do
		@channel = CinderellaChannel.new "test0", File.expand_path(File.dirname(__FILE__))
		@channel2 = CinderellaChannel.new "test1", File.expand_path(File.dirname(__FILE__))
		@failed_channel = CinderellaChannel.new "THIS ID DOESN'T EXIST", File.expand_path(File.dirname(__FILE__))
	end

	describe "#new" do
		it "returns a CinderellaChannel object" do
			expect(@channel).to be_an_instance_of CinderellaChannel
		end
		it "should fail gracefully" do
			expect(@failed_channel).to be_an_instance_of CinderellaChannel
			fileNotFound = CinderellaChannel.new "test0", "/brokenfilepath/"
			expect(fileNotFound).to be_an_instance_of CinderellaChannel
		end
	end

	describe "#identifier" do
		it "should get the Channel's identifier" do
			expect(@channel.identifier).to eq "test0"
			expect(@channel2.identifier).to eq "test1"
		end
		it "should return nil on an invalid identifier" do
			expect(@failed_channel.identifier).to eq nil
		end
	end

	describe "#name" do
		it "should get the Channel's name" do
			expect(@channel.name).to eq "Test Radio 1"
			expect(@channel2.name).to eq "Test Radio 52"
		end
	end

	describe "#description" do
		it "should get the Channel's description" do
			expect(@channel.description).to eq "testy!"
			expect(@channel2.description).to eq "heyo!"
		end
	end

	describe "#tags" do
		it "will return the Channel's possible tags" do
			expect(@channel.tags.length).to eq 2
			expect(@channel2.tags.length).to eq 3
		end
	end

	describe "#getSong" do
		it "will get the cool song from test playlist 1" do
			expect(@channel.getSong("cool").title).to eq "Cool song"
		end
		it "will get the hot song from test playlist 1" do
			expect(@channel.getSong("hot").title).to eq "Hot song"
		end
	end
end
