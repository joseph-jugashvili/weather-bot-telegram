require_relative 'helpers/output_helper'

class Weather
  include OutputHelper
  
  API_KEY = '3b68c45dd8fbdd360565e2e2f206b3c9'
  time = Time.new

  def initialize(lat, lon)
    @lat = lat
    @lon = lon
  end

  attr_accessor :lat, :lon, :time

  def weather_message
    "#{date} UTC \nToday in your location #{select_cloudiness(clouds)} \n🌡Temperature #{temperature}°C, feels like #{feeling_temp}°C \n💧Humidity #{humidity}% \n🌬Wind speed #{wind} m/s \n⏱Atmospheric pressure is #{pressure} hPa \n#{select_raininess(rain)}"
  end

  def select_cloudiness(clouds)
    cloudiness = cloudiness_variations.select { |ico| ico === clouds}.values.first
    cloudiness
  end

  def select_raininess(rain)
    raininess = raininess_variations.select { |ico| ico === rain}.values.first
    raininess
  end

  private

  def weather_url
    "api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&dt=#{time}&APPID=#{API_KEY}&units=metric"
  end

  def api_response
    @response_body ||= RestClient.get(weather_url).body
    JSON(@response_body)
  end
end
