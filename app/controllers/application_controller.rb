require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret wish"
  end

  get "/" do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :"/user/welcome"
    end
  end

  helpers do
    def current_user
      User.find_by(id: session[:id])
    end

    def logged_in?
      !!current_user
    end
  end
end
