module NdfdRestApi
  class NdfdResponse
    attr_reader :error, :data

    def initialize(xml_doc)
      parsed = Nori.parse(xml_doc)
      if parsed["error"]
        @error = {:message => parsed["error"]["pre"]}
      else
        @data = parsed["dwml"]["data"]
        # pp @data
      end
    end

    def parameters
      @data["parameters"]
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
        location_parameters = parameters_for_point(point_key)
        location["days"] = days(location_parameters)
        locations << location
      else
        @data["location"].each{|location|
          point_key = location["point_key"]
          location_parameters = parameters_for_point(point_key)
          location["days"] = days(location_parameters)
          locations << location
        }
      end
      locations
    end

    def parameters_for_point(point_key)
      if @data["parameters"].is_a? Hash
        @data["parameters"]
      elsif @data["parameters"].is_a? Array
        @data["parameters"].detect{|parameter| parameter["@applicable_location"] == point_key}
      else
        raise TypeError.new("parameters is neither Hash nor Array")
      end
    end

    def days(parameters)
      days = []
      i = 0
      while (i < num_days)
        day = {}
        day["max"] = temp(parameters["temperature"], "maximum", i)
        day["min"] = temp(parameters["temperature"], "minimum", i)
        day["pop"] = pop(parameters["probability_of_precipitation"], i)
        day["weather"] = weather(parameters["weather"], i)
        i += 1
        days << day
      end
      days
    end

    def temp(temperature_data, type, index)
      temperature_data.detect{|temp| temp["@type"] == type}["value"][index]
    end

    def pop(pop_data, index)
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
      else
        weather_data["weather_conditions"][index]["@weather_summary"]
      end
    end

  end
end
