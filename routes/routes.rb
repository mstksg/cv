class WebCV < Sinatra::Base
  get "/" do
    haml :cv
  end
end
