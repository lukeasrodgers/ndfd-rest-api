module NdfdRestApi
  class SummarizedDataForCities < SummarizedData

    class << self
      private :new

      def fetch(cities, params)
        massaged_params = {
          :citiesLevel => cities,
          :format => params[:format] || "12 hourly",
          :numDays => params[:days] || 1,
          :unit => params[:unit] || "e"
        }
        super(massaged_params)
      end

    end

  end
end
