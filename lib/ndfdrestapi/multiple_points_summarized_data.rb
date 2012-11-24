module NdfdRestApi
  class MultiplePointsSummarizedData < SummarizedData
    attr_reader :data

    class <<self
      private :new

      def fetch(points, params)
        list_lat_lon = points.reduce(""){|acc, point_set|
          acc + point_set.join(',') + " "
        }
        massaged_params = {
          :listLatLon => list_lat_lon.chop,
          :format => params[:format] || "12 hourly",
          :numDays => params[:days] || 1,
          :unit => params[:unit] || "e"
        }
        super(massaged_params)
      end

    end

  end
end
