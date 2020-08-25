require "uri"
require "httparty"
require 'pry'

class Api
    include HTTParty
    BASE_URL = "https://api.jikan.moe/v3/"
    SEARCH_URL = "https://api.jikan.moe/v3/search/anime?q="

    def self.query(input)
        url = SEARCH_URL + "#{input}"
        res = HTTParty.get(url)
        res["results"].first
    end
end