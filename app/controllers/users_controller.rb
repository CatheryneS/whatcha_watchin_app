class UsersController < ApplicationController
  get "/login" do
    erb :welcome
  end

  post '/login' do
        user = User.find_by(username: params[:user][:username])
        
        if user && user.authenticate(params[:user][:password])
          session[:user_id] = user.id
          redirect "/user/#{user.id}"
        else
          redirect '/login'
        end
      end
    
      get '/signup' do
        erb :signup
      end
    
      post '/signup' do
        if User.find_by(username: params[:user][:username]) != nil  || User.find_by(email: params[:user][:email]) != nil
          redirect '/signup'
        else
          User.create(name: params[:user][:name], username: params[:user][:username], email: params[:user][:email], password: params[:user][:password])
          redirect '/login'
        end
      end
    
      get '/user/:id' do
        @user = User.find_by_id(params[:id])
        erb :account
      end

      post '/logout' do
        session.clear
        redirect '/login'
      end
end