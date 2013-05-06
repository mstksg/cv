require_relative 'environment'

class WebCV < Sinatra::Base
  configure do
    set :public_dir, "public"
    set :views, "views"
    set :server, "thin"

    # enable :sessions
    # set :session_secret, "sosecret" 
    # set :sockets, []
    # set :dirhash, ""
  end

  configure :production do

  end

  configure :development do

  end

  helpers do
    include Rack::Utils
  end
  
end

require_relative 'routes/init'
