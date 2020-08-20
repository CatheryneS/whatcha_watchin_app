class AnimeController < ApplicationController
    get '/anime/new' do
        erb :new
    end

    post '/anime/:id' do 

    end
end