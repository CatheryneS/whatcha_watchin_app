class UsersController < ApplicationController
    post '/login' do
        user = User.find_by(username: params[:user][:username])
        
        if user && user.authenticate(params[:user][:password])
          session[:user_id] = user.id
          redirect "/user/#{user.id}"
        else
          redirect '/'
        end
      end
    
      get '/signup' do
        erb :signup
      end
    
      post '/signup' do
        if User.find_by(username: params[:user][:username]) || User.find_by(password: params[:user][:password])
          redirect '/signup'
        else
          User.create(name: params[:user][:name], username: params[:user][:username], email: params[:user][:email], password: params[:user][:password])
          redirect '/'
        end
      end
    
      get '/user/:id' do
        @user = User.find_by(params[:id])
        erb :account
      end
end