class AnimeController < ApplicationController
    get '/animes/new' do
        erb :new
    end

    get '/animes/:id' do 
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

    get '/animes/:id/edit' do
        @anime = Anime.find_by(id: params[:id])
        erb :edit
    end

    patch '/animes/:id' do
        @anime = Anime.find(params[:id])
        @anime.update(title: params[:anime][:title], status: params[:anime][:status], rating: params[:anime][:rating])
        redirect "/animes/#{@anime.id}"
    end
end