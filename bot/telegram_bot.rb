class Bot
  TOKEN = '5138871774:AAFgTD8-oq4xVHaEWuMEv_SI4HzqRN10r84'

  def run
    bot.listen do |message|
      city_weather(message)
      location_weather(message)
      case message
      when Telegram::Bot::Types::CallbackQuery
        case message.data
        when 'help'
            bot.api.send_message(chat_id: message.from.id, text: "You can get the weather forecast with /weather <Name of city>\nAlso you can enter /location to share your position whith me and get the information about weather")
        when 'info'
            bot.api.send_message(chat_id: message.from.id, text: "This bot was created to help you find out the weather forecast in any city or place.\nDeveloped by Kim Oleksii, a student of the group IO-81")
        when 'commands'
          bot.api.send_message(chat_id: message.from.id, text: "/weather <name of city> – \n/location – \n/start – calls main menu")
        end
      when Telegram::Bot::Types::Message
        case message.text
        when '/start'
            kb = [
                Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Help', callback_data: 'help'),
                Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Info', callback_data: 'info'), 
                Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Commands List', callback_data: 'commands')
            ]
            markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
            bot.api.send_message(chat_id: message.chat.id, text: "👋Hi #{message.from.first_name}! Let's get the weather forecast in your city \nMake a choice", reply_markup: markup)
        when '/location'
            kb = [
                Telegram::Bot::Types::KeyboardButton.new(text: 'Share location', request_location: true)
            ]
            markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb)
            bot.api.send_message(chat_id: message.chat.id, text: 'Let me know where are you🧐', reply_markup: markup)
        when '/weather'
          bot.api.send_message(chat_id: message.chat.id, text: "You forgot the name of the city.\nPlease try again, and don`t forget to include the name of the city after the command!")
        end
      end
    rescue StandardError => e
      puts e.message
    end
  end

  private

  def bot
    Telegram::Bot::Client.run(TOKEN) { |bot| return bot }
  end

  def city_weather(message)
    return unless message.text.include? '/weather'

    bot.api.send_message(chat_id: message.chat.id, text: WeatherCity.new(city_name(message.text)).weather_city_message)
  end

  def location_weather(message)
    if message.location != nil
      lat = message.location.latitude
      lon = message.location.longitude
      bot.api.send_message(chat_id: message.chat.id, text: Weather.new(lat, lon).weather_message)
    end
  end

  def city_name(text)
    text.gsub('/weather', '').strip.tr(' ', '+')
  end
end
