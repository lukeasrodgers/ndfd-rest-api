require 'spec_helper'

describe NdfdRestApi::UnsummarizedGlanceNdfdResponse do
  before(:all) do
    xml = File.read("./spec/fixtures/unsummarized_glance_single_point_7_days.xml")
    @response = NdfdRestApi::UnsummarizedGlanceNdfdResponse.new(xml)
  end

  describe "parse_locations" do
    before(:all) do
      @locations = @response.parse_locations
    end
    it "should parse correct number of locations out" do
      @locations.length.should == 1
    end
    it "should include correct number of days for each location" do
      @locations.each{|location|
        location["days"].length.should == 7
      }
    end
    it "should include a DateTime object for each date" do
      @locations.each{|location|
        location["days"].each{|day|
          day["date"].class.should == DateTime
        }
      }
    end
    it "should include temperature data for day per location" do
      @locations.each{|location|
        location["days"].each{|day|
          day.should have_key("max")
          day.should have_key("min")
        }
      }
    end
    it "should include weather periods for each day" do
      @locations.each{|location|
        location["days"].each{|day|
          day.should have_key("weather_periods")
        }
      }
    end
  end

end

