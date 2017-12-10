require "open_weather"

class WeatherChecker
  APP_ID = "bc44784bce947e0af6c13b9bc4459ad7"
  CITY_ID = 3873544
  RAIN_CODES = 200..599

  def self.raining?
    new.raining?
  end

  def initialize
    @response = OpenWeather::Forecast.city_id(CITY_ID, options)
  end

  def raining?
    detect_rain_in_weather_codes?
  end

  private

  def options
    { units: "metric", APPID: APP_ID, cnt: 7 }
  end

  def list_of_weather_codes
    @response["list"].map { |day| day["weather"].first["id"] }
  end

  def detect_rain_in_weather_codes?
    list_of_weather_codes.any? { |code| RAIN_CODES.member?(code) }
  end
end
