module NdfdRestApi
  class SinglePointSummarizedData < SummarizedData

    class <<self
      private :new

      def fetch(params)
        massaged_params = {
          :lat => params[:lat],
          :lon => params[:lon],
          :format => params[:format] || "12 hourly",
          :numDays => params[:days] || 1,
          :unit => params[:unit] || "e"
        }
        super(massaged_params)
      end

    end

  end
end
