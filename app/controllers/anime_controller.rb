class AnimeController < ApplicationController
    get '/animes/new' do
        erb :new
    end

    get '/animes' do
        @animes = Anime.all
        erb :account
    end

    post '/animes' do 
        binding.pry
        erb :account
    end
end