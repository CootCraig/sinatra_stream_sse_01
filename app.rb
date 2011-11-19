require 'celluloid'
require 'set'
require 'json'

class App
  @@Door_Ids = %w[101 102 103]
  @@Door_Sensors = {}
  @@Door_Reporters = {}
  def self.door_ids
    @@Door_Ids
  end
  def self.start
    @@Door_Ids.each do |door|
      @@Door_Reporters[door.to_sym] = ReportDoorEvent.new(door)
      @@Door_Sensors[door.to_sym] = DoorSensor.new(door,@@Door_Reporters[door.to_sym])
      @@Door_Sensors[door.to_sym].start!
    end
  end
  def self.door? door
    @@Door_Sensors.has_key? door.to_sym
  end
  def self.add_subscriber(door,subscriber)
    @@Door_Reporters[door.to_sym].add_subscriber(subscriber) if @@Door_Reporters[door.to_sym]
  end
end
class DoorSensor
  include Celluloid
  def initialize(door,target)
    @door = door
    @target = target
    @open = false
  end
  def start
    while true do
      sleep ((Random.rand 20) + 5)
      @open = @open ? false : true
      @target.report!(door: @door, open: @open)
    end
  end
end
class ReportDoorEvent
  include Celluloid
  def initialize(door)
    @door = door
    @subscribers = Set.new
  end
  def add_subscriber(subscriber)
    @subscribers.add subscriber
  end
  def report(door_event)
    msg = "data: #{JSON(door_event)}\n\n"
    STDOUT.puts msg
    closed_subscribers = @subscribers.inject([]) do |closed,subscriber|
      if subscriber.closed? then
        closed << subscriber
      else
        closed
      end 
    end
    closed_subscribers.each { |subscriber| @subscribers.delete subscriber }
    @subscribers.each do |subscriber|
      subscriber << msg
      subscriber.flush
    end
  end
end

