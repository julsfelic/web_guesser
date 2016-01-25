require "sinatra"
require "sinatra/reloader"

set :number, rand(100)
set :message, ""
set :color, "#FFF"
set :cheat_mode, false
set :guesses, 5

def set_color(color)
  settings.color = color
end

def set_message(message)
  settings.message = message
end

def check_guess(guess)
  if (guess - settings.number) > 5
    set_color("#F00")
    set_message("Way too high!")
  elsif (guess - settings.number) > 0
    set_color("#F77")
    set_message("Too high!")
  elsif (settings.number - guess) > 5
    set_color("#F00")
    set_message("Way too low!")
  elsif (settings.number - guess) > 0
    set_color("#F77")
    set_message("Too low!")
  elsif guess == settings.number
    set_color("#080")
    set_message("You got it right!")
  end
end

def decrement_guesses
  settings.guesses -= 1
end

def new_random_number
  settings.number = rand(100)
end

def reset_guesses
  settings.guesses = 5
end

def new_game
  new_random_number
  reset_guesses
end

def check_guesses_remaining
  decrement_guesses
  if settings.color == "green"
    new_game
  elsif settings.guesses < 0
    set_message("You've lost! A new number has been generated.")
    set_color("#F00")
    new_game
  end
end

def check_for_cheat_mode(cheat)
  settings.cheat_mode = true if cheat
end

get '/' do
  guess  = params["guess"].to_i
  number = settings.number
  check_for_cheat_mode(params["cheat"])
  check_guess(guess)
  check_guesses_remaining
  erb :index, locals: { number:  number,
                        message: settings.message,
                        color:   settings.color,
                        cheat:   settings.cheat_mode }
end
