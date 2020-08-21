class AnimeController < ApplicationController
    get '/animes/new' do
        erb :new
    end

    get '/animes/:id' do 
        binding.pry
        @anime = Anime.find_by(id: params[:id])
        erb :show
    end

    get '/animes' do
        @animes = Anime.all
        @user = current_user
        erb :account
    end

    post '/animes' do 
        Anime.create(title: params[:anime][:title], status: params[:anime][:status], rating: params[:anime][:rating], user_id: current_user.id)
        redirect '/animes'
    end
end