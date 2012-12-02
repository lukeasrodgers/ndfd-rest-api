require 'spec_helper'

describe NdfdRestApi::SummarizedNdfdResponse do
  before(:all) do
    xml = File.read("./spec/fixtures/summarized_single_point_7_days.xml")
    @response = NdfdRestApi::SummarizedNdfdResponse.new(xml)
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
    it "should include weather description for day per location" do
      @locations.each{|location|
        location["days"].each{|day|
          day["weather"].should_not be_nil
        }
      }
    end
    it "should include precipitation data for day per location" do
      @locations.each{|location|
        location["days"].each{|day|
          pop = day["pop"]
          pop["morning"].should_not be_nil
          pop["afternoon"].should_not be_nil
          pop["day"].should == (pop["morning"] + pop["afternoon"]) / 2
        }
      }
    end
  end

end
