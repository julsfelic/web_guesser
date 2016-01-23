require "sinatra"
require "sinatra/reloader"

set :number, rand(100)
set :color, "#FFF"

def check_guess(guess)
  if guess > settings.number
    if (guess - settings.number) > 5
      settings.color = "red"
      "Way too high!"
    else
      settings.color = "#F77"
      "Too high!"
    end
  elsif guess < settings.number
    if (settings.number - guess) > 5
      settings.color = "red"
      "Way too low!"
    else
      settings.color = "#F77"
      "Too low!"
    end
  elsif guess == settings.number
    settings.color = "green"
    "You got it right!"
  end
end

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess)
  erb :index, locals: { number: settings.number,
                        message: message,
                        color: settings.color }
end
