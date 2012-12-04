module NdfdRestApi
  class ZipcodeListSummarizedData < SummarizedData

    class << self
      private :new

      def fetch(zipcodes, params)
        zipcodes = zipcodes.join("+")
        massaged_params = {
          :zipCodeList => zipcodes,
          :format => params[:format] || "12 hourly",
          :numDays => params[:days] || 1,
          :unit => params[:unit] || "e"
        }
        super(massaged_params)
      end

    end

  end
end
