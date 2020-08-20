class AnimeController < ApplicationController
    get '/animes/new' do
        erb :new
    end

    post '/animes' do 
        binding.pry
        erb :account
    end
end