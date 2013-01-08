module NdfdRestApi
  class ZipcodeListSummarizedData < SummarizedData

    class << self
      private :new

      def fetch(zipcodes, params)
        zipcodes = zipcodes.join("+")
        massaged_params = params.merge({
          :zipCodeList => zipcodes
        })
        super(massaged_params)
      end

    end

  end
end
