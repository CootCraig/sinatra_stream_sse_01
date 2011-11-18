require 'celluloid'
class Gen
  include Celluloid
  def initialize name
    @name = name
  end
  def start
    while true do
      sleep ((Random.rand 6) + 2)
      Celluloid::Actor[:show].show!("Look at me I'm #{@name}")
    end
  end
end
class Show
  include Celluloid
  def show(msg)
    STDOUT.puts msg
  end
end

Celluloid::Actor[:show] = Show.new
Celluloid::Actor[:Bozo] = Gen.new "Bozo"
Celluloid::Actor[:Beezer] = Gen.new "Beezer"
Celluloid::Actor[:elvis] = Gen.new "Elvis"
Celluloid::Actor[:Bozo].start!
Celluloid::Actor[:Beezer].start!
Celluloid::Actor[:elvis].start!
sleep 20
Celluloid::Actor[:show].show! "Shutting down"

