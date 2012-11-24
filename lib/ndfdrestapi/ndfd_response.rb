module NdfdRestApi
  class NdfdResponse
    attr_reader :error, :data

    def initialize(xml_doc)
      parsed = Nori.parse(xml_doc)
      if parsed["error"]
        @error = {:message => parsed["error"]["pre"]}
      else
        @data = parsed["dwml"]["data"]
        @num_days = num_days
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
        location["parameters"] = parameters_for_point(location["point_key"])
        locations << location
      else
        @data["location"].each{|location|
          pp location
          point_key = location["location_key"]
          location["parameters"] = parameters_for_point(point_key)
          locations << location
        }
      end
      locations
    end

    def parameters_for_point(point_key)
      if @data["parameters"].is_a? Hash
        @data["parameters"]
      elsif @data["parameters"].is_a? Array
        @data["parameters"].detect{|parameter| parameter["@applicable-location"] == point_key}
      else
        raise TypeError.new("parameters is neither Hash nor Array")
      end
    end

  end
end
