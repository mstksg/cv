class WebCV < Sinatra::Base
  get "/" do
    haml :cv, :locals => { :watch => !!params[:watch],
                            :data => template_data }
  end
end
