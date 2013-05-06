require_relative 'environment'

class WebCV < Sinatra::Base
  configure do
    set :public_dir, "public"
    set :views, "views"
    set :server, "thin"
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
