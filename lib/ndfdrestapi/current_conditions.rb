module NdfdRestApi
  class CurrentConditions
    attr_reader :parsed

    class <<self
      private :new

      def fetch(lat, lon)
        params = {
          :lat => lat,
          :lon => lon,
          :format => "24 hourly",
          :numDays => 7
        }
        xml_doc = HttpService.get(:summarized, params)
        parsed = Nori.parse(xml_doc)
        new(parsed)
      end

    end

    def initialize(parsed)
      @parsed = parsed
    end

  end
end
