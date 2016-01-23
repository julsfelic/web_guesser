require "sinatra"
require "sinatra/reloader"

@@guesses = 5
@@cheat_mode = false

set :number, rand(100)
set :message, ""
set :color, "#FFF"

def check_guess(guess)
  if guess > settings.number
    if (guess - settings.number) > 5
      settings.color = "red"
      settings.message = "Way too high!"
    else
      settings.color = "#F77"
      settings.message = "Too high!"
    end
  elsif guess < settings.number
    if (settings.number - guess) > 5
      settings.color = "red"
      settings.message = "Way too low!"
    else
      settings.color = "#F77"
      settings.message = "Too low!"
    end
  elsif guess == settings.number
    settings.color = "green"
    settings.message = "You got it right!"
  end
end

def check_guesses_remaining
  @@guesses -= 1
  if settings.color == "green"
    settings.number = rand(100)
    @@guesses = 5
  elsif @@guesses == 0
    settings.number = rand(100)
    @@guesses = 5
    settings.message = "You've lost! A new number has been generated."
  end
end

get '/' do
  guess = params["guess"].to_i
  @@cheat_mode = true if params["cheat"]
  number = settings.number
  check_guess(guess)
  check_guesses_remaining
  erb :index, locals: { number: number,
                        message: settings.message,
                        color: settings.color,
                        cheat: @@cheat_mode }
end
