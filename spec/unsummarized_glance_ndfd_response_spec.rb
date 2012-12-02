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
    it "should include weather periods, with time_period, for each day" do
      @locations.each{|location|
        location["days"].each{|day|
          day["weather_periods"].each{|wp|
            wp.should have_key("time_period")
          }
        }
      }
    end
    it "should include hazard periods for each day" do
      @locations.each{|location|
        location["days"].each{|day|
          day.should have_key("hazard_periods")
        }
      }
    end
    it "should include cloud amount periods, with time_period, for each day" do
      @locations.each{|location|
        location["days"].each{|day|
          day["cloud_amount_periods"].each{|cap|
            cap.should have_key("time_period")
          }
        }
      }
    end
  end

end

