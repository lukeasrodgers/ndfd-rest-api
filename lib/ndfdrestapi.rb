require_relative "ndfdrestapi/current_conditions"
require_relative "ndfdrestapi/http_service"
require_relative "ndfdrestapi/ndfd_response"
require_relative "ndfdrestapi/summarized_data"
require_relative "ndfdrestapi/single_point_summarized_data"
require_relative "ndfdrestapi/multiple_points_summarized_data"

require "open-uri"
require "nori"

module NdfdRestApi
  # Your code goes here...
  class <<self
    def current_conditions(lat, lon)
      CurrentConditions.fetch(lat, lon)
    end
    def sps(params)
      SinglePointSummarizedData.fetch(params)
    end
    def mps(points, params)
      MultiplePointsSummarizedData.fetch(points, params)
    end
  end
end
