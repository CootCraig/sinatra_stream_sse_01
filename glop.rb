require 'celluloid'
class Gen
  include "Celluloid"
  def start
    while true do
      sleep ((Random.rand 3*60) + 20)
      Celluloid::Actor[:show].show!("hello")
    end
  end
end
class Show
  include "Celluloid"
  def show(msg)
    STDOUT.puts msg
  end
end

