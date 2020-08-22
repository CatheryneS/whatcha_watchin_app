require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "#{Sysrandom.hex(64)}"
  end

  get "/" do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :welcome
    end
  end

  helpers do
    def current_user
      @user = User.find_by(session[:user_id])
  end

    def logged_in?
        !!current_user
    end
  end
end
