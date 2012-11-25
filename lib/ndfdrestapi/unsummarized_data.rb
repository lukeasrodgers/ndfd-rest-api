module NdfdRestApi
  class UnsummarizedData
    attr_reader :data, :locations

    class << self
      private :new

      def fetch(params)
        massage_param_elements(params)
        xml_doc = HttpService.get(:unsummarized, params)
        if (params[:product] == "glance")
          response = UnsummarizedGlanceNdfdResponse.new(xml_doc)
        elsif (params[:product] == "time-series")
          response = UnsummarizedTimeSeriesNdfdResponse.new(xml_doc)
        end
        new(response)
      end

      private

      # take elements array of strings, and set as
      # symbol keys on params hash
      def massage_param_elements(params)
        elements = params[:elements]
        params.delete(:elements)
        elements.each{|element|
          params[element.to_sym] = element
        }
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
