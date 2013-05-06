$SOCKETS ||= []

class WebCV < Sinatra::Base
  get "/sockets/watch" do
    if request.websocket?
      request.websocket do |ws|
        ws.onopen do
          settings.sockets << ws
        end
        ws.onmessage do |msg|
          dirhash = `grep '' -Rh . | md5sum`
          if dirhash != settings.dirhash
            settings.sockets.each { |s| EM.next_tick { s.send("1") } }
            settings.dirhash = dirhash
          end
        end
        ws.onclose do
          settings.sockets.delete ws
        end
      end
    else
      return 500
    end
  end
end
