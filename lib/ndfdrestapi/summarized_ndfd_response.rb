module NdfdRestApi
  class SummarizedNdfdResopnse < NdfdResponse

    private

    def days(parameters)
      days = []
      i = 0
      while (i < num_days)
        day = {}
        day["date"] = date(i)
        day["max"] = temp(parameters["temperature"], "maximum", i)
        day["min"] = temp(parameters["temperature"], "minimum", i)
        day["pop"] = probability_of_precipitation(parameters["probability_of_precipitation"], i)
        day["weather"] = weather(parameters["weather"], i)
        i += 1
        days << day
      end
      days
    end

  end
end
