module NdfdRestApi
  class NdfdResponse
    attr_reader :error, :data

    def initialize(xml_doc)
      parsed = Nori.parse(xml_doc)
      if parsed["error"]
        @error = {:message => parsed["error"]["pre"]}
      else
        @data = parsed["dwml"]["data"]
      end
    end

    def locations
      locations = @data["location"]
    end

    def num_days
      @data["time_layout"].first["layout_key"].match(/-n\d*/).to_s[2..-1].to_i
    end

    def num_locations
      location = @data["location"]
      if location.is_a? Hash
        1
      elsif location.is_a? Array
        location.length
      else
        raise TypeError.new("locations is neither Hash nor Array")
      end
    end

    def parse_locations
      locations = []
      if (num_locations == 1)
        location = @data["location"]
        point_key = location["point_key"]
        parameters = parameters_for_point(point_key)
        location["days"] = days(parameters)
        location["any_data"] = any_data?(parameters)
        locations << location
      else
        @data["location"].each{|location|
          point_key = location["location_key"]
          parameters = parameters_for_point(point_key)
          location["days"] = days(parameters)
          location["any_data"] = any_data?(parameters)
          locations << location
        }
      end
      locations
    end

    private

    def parameters_for_point(point_key)
      if @data["parameters"].is_a? Hash
        @data["parameters"]
      elsif @data["parameters"].is_a? Array
        @data["parameters"].detect{|parameter| parameter["@applicable_location"] == point_key}
      else
        raise TypeError.new("parameters is neither Hash nor Array")
      end
    end

    def date(index)
      if @data["time_layout"].first["start_valid_time"].is_a? Array
        @data["time_layout"].first["start_valid_time"][index]
      else
        @data["time_layout"].first["start_valid_time"]
      end
    end

    def temp(temperature_data, type, index)
      temp = temperature_data.detect{|temp| temp["@type"] == type}
      if (temp["value"].is_a? Array)
        temp["value"][index]
      else
        temp["value"]
      end
    end

    def probability_of_precipitation(pop_data, index)
      if (pop_data["@type"] == "12 hour")
        morning = pop_data["value"][index].to_i
        afternoon = pop_data["value"][index + 1].to_i
        day = (morning + afternoon) / 2
        {
          "morning" => morning,
          "afternoon" => afternoon,
          "day" => day
        }
      else
        {
          "day" => pop_data["value"][index]
        }
      end
    end

    def weather(weather_data, index)
      # TODO make checking for period consistent
      if (weather_data["@time_layout"].include? "24h")
        weather_summary(weather_data, index)
      else
        {
          "morning" => weather_summary(weather_data, index),
          "afternoon" => weather_summary(weather_data, index + 1)
        }
      end
    end

    def weather_summary(weather_data, index)
      if (weather_data["weather_conditions"].is_a? Hash)
        weather_data["weather_conditions"]["@weather_summary"]
      elsif weather_data["weather_conditions"][index]
        weather_data["weather_conditions"][index]["@weather_summary"]
      else
        weather_data["weather_conditions"][index]
      end
    end

    def any_data?(location_parameters)
      temp(location_parameters ["temperature"], "maximum", 0) != nil
    end

  end
end
