module NdfdRestApi
  class SummarizedData
    attr_reader :data, :locations

    class << self
      private :new

      def fetch(params)
        xml_doc = HttpService.get(:summarized, params)
        response = NdfdResponse.new(xml_doc)
        new(response)
      end

    end

    def initialize(response)
      if response.error
        raise "#{response.error[:message]}"
      else
        @locations = response.parse_locations
        @data = response.data
        # @units = temperature.first["@units"]
      end
    end
  end
end
