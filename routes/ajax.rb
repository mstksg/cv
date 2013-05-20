class WebCV < Sinatra::Base
  post "/a/dirhash" do
    return [ 200, { :dirhash => "#{`grep '' -Rh . | md5sum`}" }.to_json ]
  end

  post "/a/skills" do
    return [1,2,3].to_json
  end
end

