module OutputHelper
  def date
    date = Time.new
    date
  end

  def temperature
    api_response.dig('main', 'temp')
  end

  def humidity
    api_response.dig('main', 'humidity')
  end

  def clouds   
    api_response.dig('clouds', 'all')
  end

  def wind
    api_response.dig('wind', 'speed')
  end

  def pressure
    api_response.dig('main', 'pressure')
  end

  def rain
    api_response.dig('rain', 'rain.1h').to_i
  end

  def feeling_temp
    api_response.dig('main', 'feels_like')
  end

  def raininess_variations
    {
      0 => '☂️Rainfall is not observed',
      1..2 => '☔️There is light rain',
      3..8 => '🌦There is moderate rain',
      9..50 => '🌧There is heavy rain'
    }
  end

  def cloudiness_variations
    {
      0..10 => 'clear sky☀️',
      11..25 => 'few clouds observed🌤',
      26..50 => 'scattered clouds observed⛅️',
      51..84 => 'cloudy🌥',
      85..100 => 'mainly cloudy☁️'
    }
  end
end
