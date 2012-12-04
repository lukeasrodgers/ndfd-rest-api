require_relative "ndfdrestapi/http_service"
require_relative "ndfdrestapi/ndfd_response"
require_relative "ndfdrestapi/summarized_ndfd_response"
require_relative "ndfdrestapi/unsummarized_ndfd_response"
require_relative "ndfdrestapi/unsummarized_glance_ndfd_response"
require_relative "ndfdrestapi/unsummarized_time_series_ndfd_response"
require_relative "ndfdrestapi/summarized_data"
require_relative "ndfdrestapi/single_point_summarized_data"
require_relative "ndfdrestapi/zipcode_list_summarized_data"
require_relative "ndfdrestapi/summarized_data_for_line"
require_relative "ndfdrestapi/summarized_data_for_cities"
require_relative "ndfdrestapi/summarized_data_for_subgrid"
require_relative "ndfdrestapi/current_conditions"
require_relative "ndfdrestapi/multiple_points_summarized_data"
require_relative "ndfdrestapi/unsummarized_data"
require_relative "ndfdrestapi/single_point_unsummarized_data"

require "open-uri"
require "nori"

module NdfdRestApi
  class << self
    def current_conditions(lat, lon)
      CurrentConditions.fetch(lat, lon)
    end
    def sps(params)
      SinglePointSummarizedData.fetch(params)
    end
    def mps(points, params)
      MultiplePointsSummarizedData.fetch(points, params)
    end
    def spu(params)
      SinglePointUnsummarizedData.fetch(params)
    end
    def summarized_data_for_line(line_params, params)
      SummarizedDataForLine.fetch(line_params, params)
    end
    def zu(zipcodes, params)
      ZipcodeListSummarizedData.fetch(zipcodes, params)
    end
    def summarized_data_for_cities(cities, params)
      SummarizedDataForCities.fetch(cities, params)
    end
    def summarized_data_for_subgrid(grid_params, params)
      SummarizedDataForSubgrid.fetch(grid_params, params)
    end
  end
end
