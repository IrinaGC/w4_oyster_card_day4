class Journey

 MIN_FARE = 1

attr_accessor :entry_station, :exit_station, :arr

def initialize
 @entry_station = nil
 @exit_station = nil
 @arr = []
#  @journey_history = {}

end

def start_journey
  @arr << @entry_station if @entry_station != nil
  @arr.length == 1
end

def in_journey
  @arr.length == 1
end

def end_journey
  @arr << @exit_station if @exit_station != nil
  @arr.length == 2
end

def fare
    @arr.length == 2 ? 1 : 6
  
end

end