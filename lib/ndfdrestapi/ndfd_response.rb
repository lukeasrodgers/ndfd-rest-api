module NdfdRestApi
  class NdfdResponse
    attr_reader :error, :data

    def initialize(xml_doc)
      parsed = Nori.parse(xml_doc)
      if parsed["error"]
        @error = {:message => parsed["error"]["pre"]}
      else
        @data = parsed["dwml"]["data"]
      end
    end

  end
end
