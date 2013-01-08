module NdfdRestApi
  class SummarizedData
    attr_reader :data, :locations

    class << self
      private :new

      def fetch(params)
        massaged_params = params.merge({
          :format => params[:format] || "12 hourly",
          :numDays => params[:days] || 1,
          :unit => params[:unit] || "e"
        })
        massaged_params.delete(:days)
        xml_doc = HttpService.get(:summarized, massaged_params)
        response = SummarizedNdfdResponse.new(xml_doc)
        new(response)
      end

    end

    def initialize(response)
      if response.error
        raise "#{response.error[:message]}"
      else
        @locations = response.parse_locations
        @data = response.data
      end
    end
  end
end
