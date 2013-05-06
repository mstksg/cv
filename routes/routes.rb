class WebCV < Sinatra::Base
  get "/" do
    haml :cv, :locals => { :watch => !!params[:watch] }
  end
end
