require_relative 'helpers/output_helper'

class WeatherCity < Weather
  include OutputHelper

  #API_СITY_KEY = '3b68c45dd8fbdd360565e2e2f206b3c9'

  def initialize(city)
    @city = city
  end

  attr_accessor :city

  def weather_city_message
    "#{date} UTC \nToday in #{city} #{select_cloudiness(clouds)} \n🌡Temperature #{temperature}°C, feels like #{feeling_temp}°C \n💧Humidity #{humidity}% \n🌬Wind speed #{wind} m/s \n⏱Atmospheric pressure is #{pressure} hPa \n#{select_raininess(rain)}"
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