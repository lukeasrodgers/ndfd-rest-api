module NdfdRestApi
  class CurrentConditions < SinglePointSummarizedData

    class <<self
      private :new

      def fetch(lat, lon)
        params = {
          :lat => lat,
          :lon => lon,
        }
        super(params)
      end

    end

    def initialize(response)
      super(response)
    end

    def today
      @locations.first["days"].first
    end

  end
end
