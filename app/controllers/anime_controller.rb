class AnimeController < ApplicationController
    get '/animes/new' do
        erb :"/list/new"
    end

    get '/animes/:id' do 
        @anime = Anime.find_by(id: params[:id])
        erb :"/list/show"
    end

    get '/animes' do
        if logged_in?
            @user = current_user
            @animes = Anime.all.select{ |a| a.user_id == @user.id}

            erb :"/list/account"
        else
            erb :"/user/welcome"
        end
    end

    post '/animes' do 
        binding.pry
        Anime.create(title: params[:anime][:title], status: params[:anime][:status], rating: params[:anime][:rating], user_id: current_user.id)
        redirect '/animes'
    end

    get '/animes/:id/edit' do
        @anime = Anime.find_by(id: params[:id])
        if current_user.id == @anime.user_id
            erb :"/list/edit"
        else
            redirect '/animes/:id'
        end
    end

    patch '/animes/:id' do
        @anime = Anime.find(params[:id])
        @anime.update(title: params[:anime][:title], status: params[:anime][:status], rating: params[:anime][:rating])
        redirect "/animes/#{@anime.id}"
    end

    delete '/animes/:id' do
        @anime = Anime.find(params[:id])
        @anime.destroy
        redirect '/animes'
    end
end