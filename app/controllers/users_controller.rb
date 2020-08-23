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
      flash[:welcome] = "Glad to see you again."
      redirect "/users/#{@user.id}"
    else
      flash[:error] = "Credentials unknown. Please try again or sign up."
      redirect '/login'
    end
  end
    
  get '/users/:id' do 
    @user = User.find_by_id(params[:id])
    if logged_in?
      @animes = Anime.all.select{ |a| a.user_id == @user.id}      
      @new_user = "Get started by adding your first anime."
      erb :"/list/account"
    else
      redirect '/login'
    end
  end
  
  get '/signup' do
    erb :"/user/signup"
  end
    
  post '/signup' do
    if User.find_by(username: params[:user][:username]) != nil  || User.find_by(email: params[:user][:email]) != nil
      flash[:oops] = "Hmm... The username or email has already been used. Please try again." 
      redirect '/signup'
    else
      User.create(name: params[:user][:name], username: params[:user][:username], email: params[:user][:email], password: params[:user][:password])
      flash[:singup] = "You have successfully signed up! Please sign in."
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    flash[:logout] = "See you later!"
    redirect '/login'
  end
end