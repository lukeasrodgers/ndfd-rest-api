module NdfdRestApi
  class SummarizedDataForSubgrid < SummarizedData

    class << self
      private :new

      def fetch(grid_params, params)
        massaged_params = {
          :centerPointLat => grid_params[:center_lat],
          :centerPointLon => grid_params[:center_lon],
          :distanceLat => grid_params[:distance_lat],
          :distanceLon => grid_params[:distance_lon],
          :resolution => grid_params[:resolution],
          :format => params[:format] || "12 hourly",
          :numDays => params[:days] || 1,
          :unit => params[:unit] || "e"
        }
        super(massaged_params)
      end

    end

  end
end
