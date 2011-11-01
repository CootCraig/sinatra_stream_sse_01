require 'celluloid'
require 'set'
require 'json'

class App
  @@Door_numbers = %w[101 102 103]
  @@Door_events = {}
  @@Event_streams = {}
  def self.start
    @@Door_numbers.each do |door|
      @@Event_streams[door.to_sym] = EventStream.new(door)
      @@Door_events[door.to_sym] = DoorEvents.new(door,@@Event_streams[door.to_sym])
      @@Door_events[door.to_sym].start!
    end
  end
  def self.door? door
    @@Door_events.has_key? door.to_sym
  end
end
class DoorEvents
  include "Celluloid"
  def initialize(door,target)
    @door = door
    @target = target
    @open = false
  end
  def start
    while true do
      sleep ((Random.rand 3*60) + 20)
      @open = @open ? false : true
      @target.send({door: @door, open: @open})
    end
  end
end
class EventStream
  include "Celluloid"
  def initialize(door)
    @door = door
    @connections = Set.new
  end
  def add_connection(connection)
    @connections.add connection
  end
  def send(event)
    msg = "data: #{JSON(event)}\n\n"
    closed_connections = @connections.inject([]) { |closed,connection| if connection.close? then closed<<connection else closed end}
    closed_connections.each { |connection| @connections.delete connection }
    @connections.each do |connection|
      connection << msg
      connection.flush
    end
  end
end

