require 'spec_helper'

describe NdfdRestApi::NdfdResponse do
  before(:all) do
    @path = "./fixtures/xmlclient.xml"
    @xml = File.read("./spec/fixtures/xmlclient.xml")
    @response = NdfdRestApi::NdfdResponse.new(@xml)
  end

  describe "initialize" do
    it "should have parsed data" do
      @response.data.should_not be_nil
    end
  end

  describe "locations" do
    it "should have a location_key" do
      @response.locations["location_key"].should_not be_nil
    end
    it "should have a point with latitude and longitude" do
      point = @response.locations["point"]
      point["@latitude"].should == "38.99"
      point["@longitude"].should == "-77.01"
    end
  end

  describe "num_locations" do
    it "should return the number of locations as an integer" do
      @response.num_locations.should == 1
    end
  end

  describe "num_days" do
    it "should return the number days as an integer" do
      @response.num_days.should == 7
    end
  end

end
