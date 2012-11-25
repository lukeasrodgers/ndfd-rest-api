module NdfdRestApi
  class UnsummarizedGlanceNdfdResponse < NdfdResponse

    def days(parameters)
      days = []
      i = 0
      pp "days #{num_days}"
      while (i < num_days)
        day = {}
        day["date"] = date(i)
        day["max"] = temp(parameters["temperature"], "maximum", i)
        day["min"] = temp(parameters["temperature"], "minimum", i)
        day["weather_periods"] = weather_periods(parameters["weather"], day["date"])
        # day["hazard_periods"] = hazard_periods(parameters["hazards"])
        i += 1
        days << day
      end
      days
    end

    private

    def weather_periods(weather_data, date)
      periods = []
      time_layout_key = weather_data["@time_layout"]
      time_layout = @data["time_layout"].detect{|time_layout| time_layout["layout_key"] == time_layout_key }["start_valid_time"]
      time_layout.each_index{|index|
        start_time = time_layout[index]
        if (Time.parse(start_time.to_s).to_date === Time.parse(date.to_s).to_date)
          periods << weather_data["weather_conditions"][index]
        end
      }
      periods
      # pp "periods: #{periods}"
    end

    def hazard_periods(hazards_data)
      raise "Not defined yet"
    end

  end
end
