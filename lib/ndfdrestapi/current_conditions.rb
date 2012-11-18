module NdfdRestApi
  class CurrentConditions
    attr_reader :conditions

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
        parsed = Nori.parse(xml_doc)
        new(parsed)
      end

    end

    def initialize(parsed)
      @data = parsed["dwml"]["data"]
      @conditions = {}
      parameters = @data["parameters"]
      temperature = parameters["temperature"]
      max = temperature.detect{|temp| temp["@type"] == "maximum" }["value"]
      min = temperature.detect{|temp| temp["@type"] == "minimum" }["value"]
      @conditions[:max] = max.to_i
      @conditions[:min] = min.to_i
    end

  end
end
