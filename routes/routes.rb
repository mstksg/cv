class WebCV < Sinatra::Base
  get "/:view?" do
    haml :cv, :locals => { :watch => !!params[:watch],
                            :data => template_data(params[:view]) }
  end
end
