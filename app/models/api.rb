require 'json'
require 'net/http'

class Api
    def initialize 

    end

    def get_api_response
        endpoint = "https://api.jikan.moe/v3/search/anime?q=" 
        uri = URI.parse(URI.encode(endpoint))
        api_response = Net::HTTP.get(uri)
        JSON.parse(api_response)
    end
end