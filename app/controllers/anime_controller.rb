class AnimeController < ApplicationController
    get '/animes/new' do
        if logged_in?
            erb :"/list/new"
        else
            redirect '/login'
        end
    end

    get '/animes/:id' do 
        if logged_in?
            @anime = Anime.find_by(id: params[:id])
            @details = Api.query(@anime.title)
            # binding.pry
            erb :"/list/show"
        else
            redirect '/login'
        end
    end

    get '/animes' do
        if logged_in?
            @user = current_user
            @animes = Anime.all.select{ |a| a.user_id == @user.id}
            # binding.pry
            erb :"/list/account"
        else
            erb :"/user/welcome"
        end
    end

    post '/animes' do
        Anime.create(title: params[:anime][:title], status: params[:anime][:status], rating: params[:anime][:rating], user_id: current_user.id)
        flash[:created] = "You've successfully added a new anime."
        redirect '/animes'
    end

    get '/animes/:id/edit' do
        @anime = Anime.find_by(id: params[:id])
        if current_user == nil
            redirect '/login'
        elsif current_user.id == @anime.user_id
            erb :"/list/edit"
        end
    end

    patch '/animes/:id' do
        @anime = Anime.find(params[:id])
        @anime.update(title: params[:anime][:title], status: params[:anime][:status], rating: params[:anime][:rating])
        flash[:created] = "You've successfully added a new anime."
        redirect "/animes/#{@anime.id}"
    end

    delete '/animes/:id' do
        @anime = Anime.find(params[:id])
        if current_user.id == @anime.user_id && logged_in?
            @anime.destroy
            redirect '/animes'
        else
            redirect '/login'
        end
    end
end