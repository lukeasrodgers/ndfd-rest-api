module NdfdRestApi
  class CurrentConditions
    attr_reader :conditions, :units

    class <<self
      private :new

      def fetch(lat, lon)
        params = {
          :lat => lat,
          :lon => lon,
          :format => "24 hourly",
          :numDays => 1
        }
        xml_doc = HttpService.get(:summarized, params)
        response = NdfdResponse.new(xml_doc)
        new(response)
      end

    end

    def initialize(response)
      if response.error
        raise "#{response.error[:message]}"
      else
        @conditions = {}
        parameters = response.parameters
        temperature = parameters["temperature"]
        max = temperature.detect{|temp| temp["@type"] == "maximum" }["value"]
        min = temperature.detect{|temp| temp["@type"] == "minimum" }["value"]
        @conditions[:max] = max.to_i
        @conditions[:min] = min.to_i
        @units = temperature.first["@units"]
      end
    end

  end
end
