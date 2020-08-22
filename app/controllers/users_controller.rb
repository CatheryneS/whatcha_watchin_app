class UsersController < ApplicationController
  get '/login' do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :"/user/welcome"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:user][:username])
        
    if @user && @user.authenticate(params[:user][:password])
      session[:id] = @user.id
      redirect "/users/#{@user.id}"
    else
      redirect '/login'
    end
  end
    
  get '/users/:id' do
    @user = User.find_by_id(params[:id])
    @animes = Anime.all.select{ |a| a.user_id == @user.id}      
    @new_user = "Get started by adding your first anime."
    erb :"/list/account"
  end
  
  get '/signup' do
    erb :"/user/signup"
  end
    
  post '/signup' do
    if User.find_by(username: params[:user][:username]) != nil  || User.find_by(email: params[:user][:email]) != nil
      redirect '/signup'
    else
      User.create(name: params[:user][:name], username: params[:user][:username], email: params[:user][:email], password: params[:user][:password])
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    binding.pry
    redirect '/login'
  end
end