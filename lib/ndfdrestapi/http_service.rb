module NdfdRestApi
  class HttpService
    class <<self
      NDFD_CLIENTS = {
        :unsummarized => "ndfdXMLclient",
        :summarized => "ndfdBrowserClientByDay"
      }

      def get(client_type, params)
        uri = make_uri(NDFD_CLIENTS[client_type], params)
        open(uri)
      end

      def make_uri(client_type, params)
        query_string = self.query_stringify_params(params)
        uri = "http://graphical.weather.gov/xml/sample_products/browser_interface/#{client_type}.php?" + query_string
      end

      def query_stringify_params(params)
        URI::encode(params.map{|k,v| "#{k}=#{v}"}.join("&"))
      end

    end
  end
end
