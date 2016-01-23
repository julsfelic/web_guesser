require "sinatra"
require "sinatra/reloader"

set :number, rand(100)

def check_guess(guess)
  if guess > settings.number
    if (guess - settings.number) > 5
      "Way too high!"
    else
      "Too high!"
    end
  elsif guess < settings.number
    if (settings.number - guess) > 5
      "Way too low!"
    else
      "Too low!"
    end
  elsif guess == settings.number
    "You got it right!"
  end
end

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess)
  erb :index, locals: { number: settings.number, message: message }
end
