require_relative 'helpers/output_helper'

class WeatherCity < Weather
  include OutputHelper

  def initialize(city)
    @city = city
  end

  attr_accessor :city

  def weather_city_message
    "#{date} \nThere is #{select_cloudiness(clouds)} in #{city} today \n🌡Temperature #{temperature}°C, feels like #{feeling_temp}°C \n💧Humidity #{humidity}% \n🌬Wind speed #{wind} m/s \n⏱Atmospheric pressure is #{pressure} hPa \n#{select_raininess(rain)}"
  end

  private

  def weather_city_url
    "api.openweathermap.org/data/2.5/weather?q=#{city}&APPID=#{API_KEY}&units=metric"
  end

  def api_response
    @response_body ||= RestClient.get(weather_city_url).body
    JSON(@response_body)
  end
end