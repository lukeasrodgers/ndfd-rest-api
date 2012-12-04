module NdfdRestApi
  class SummarizedDataForLine < SummarizedData

    class << self
      private :new

      def fetch(line_params, params)
        massaged_params = {
          :endPoint1Lat => line_params[0][:lat],
          :endPoint1Lon => line_params[0][:lon],
          :endPoint2Lat => line_params[1][:lat],
          :endPoint2Lon => line_params[1][:lon],
          :format => params[:format] || "12 hourly",
          :numDays => params[:days] || 1,
          :unit => params[:unit] || "e"
        }
        super(massaged_params)
      end

    end

  end
end
