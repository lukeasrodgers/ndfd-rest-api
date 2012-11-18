require_relative "ndfdrestapi/current_conditions"
require_relative "ndfdrestapi/http_service"

require "open-uri"
require "nori"

module NdfdRestApi
  # Your code goes here...
  class <<self
    def current_conditions(lat, lon)
      CurrentConditions.fetch(lat, lon)
    end
  end
end
