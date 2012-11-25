module NdfdRestApi
  class SinglePointUnsummarizedData < UnsummarizedData

    class << self
      private :new

      def fetch(params)
        massaged_params = {
          :lat => params[:lat],
          :lon => params[:lon],
          :product => params[:product] || "glance",
          :begin => params[:begin] || nil,
          :end => params[:begin] || nil,
          :unit => params[:unit] || "e",
          :elements => params[:elements] || []
        }
        super(massaged_params)
      end

    end

  end
end
