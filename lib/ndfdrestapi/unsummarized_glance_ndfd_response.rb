module NdfdRestApi
  class UnsummarizedGlanceNdfdResponse < NdfdResponse

    def days(parameters)
      days = []
      i = 0
      while (i < num_days)
        day = {}
        day["date"] = date(i)
        day["max"] = temp(parameters["temperature"], "maximum", i)
        day["min"] = temp(parameters["temperature"], "minimum", i)
        day["weather_periods"] = weather_periods(parameters["weather"], day["date"])
        day["hazard_periods"] = hazard_periods(parameters["hazards"], day["date"])
        day["cloud_amount_periods"] = cloud_periods(parameters["cloud_amount"], day["date"])
        i += 1
        days << day
      end
      days
    end

    private

    def weather_periods(weather_data, date)
      periods_parser("weather_conditions", weather_data, date)
    end

    def hazard_periods(hazards_data, date)
      periods_parser("hazard_conditions", hazards_data, date)
    end

    def cloud_periods(cloud_amount_data, date)
      periods_parser("value", cloud_amount_data, date)
    end

    def periods_parser(key, data, date)
      periods = []
      time_layout_key = data["@time_layout"]
      time_layout = @data["time_layout"].detect{|time_layout| time_layout["layout_key"] == time_layout_key }["start_valid_time"]
      time_layout.each_index{|index|
        start_time = time_layout[index]
        if (Time.parse(start_time.to_s).to_date === Time.parse(date.to_s).to_date)
          period = data[key][index]
          if (period.is_a? Hash)
            period["time_period"] = start_time
          else
            period = {
              "value" => period,
              "time_period" => start_time
            }
          end
          periods << period
        end
      }
      periods.compact!
      periods.length > 0 ? periods : nil
    end


  end
end
