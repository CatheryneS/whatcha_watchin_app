require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "#{Sysrandom.hex(64)}"
  end

  get "/" do
    erb :welcome
  end

  post '/login' do
    # binding.pry
    user = User.find_by(username: params[:user][:username])
    
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect "/account/#{user.id}"
    else
      redirect '/'
    end
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    User.create(name: params[:user][:name], username: params[:user][:username], email: params[:user][:email], password: params[:user][:password])
    redirect '/'
  end

  get '/account/:id' do
    @user = User.find_by(params[:id])
    erb :account
  end

end
