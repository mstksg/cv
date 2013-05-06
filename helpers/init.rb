require_relative 'faker_helpers'
require_relative 'templating'

class WebCV < Sinatra::Base
  helpers FakerHelpers
  helpers Templating
end
