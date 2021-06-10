require "journey"

describe Journey do

 let(:entry_station) { double :entry_station } 
 let(:exit_station) { double :exit_station } 

  it "can start a journey" do
    journey = Journey.new
    journey.entry_station = "Victoria"
    expect(journey.start_journey).to eq(true)
  end

  it "is in journey" do
    journey = Journey.new
    journey.entry_station = "Victoria"
    journey.start_journey
    expect(journey.in_journey).to eq(true)
  end

  it "can end a journey" do
    journey = Journey.new
    journey.entry_station = "Victoria"
    journey.exit_station = "Pimlico"
    journey.start_journey
    expect(journey.end_journey).to eq(true)
  end

  # it "checks if journey is complete" do
  #   journey = Journey.new(entry_station, exit_station)
  #   expect(journey.end_journey).to eq(false)
  # end

  it "can calculate a fare" do
    journey = Journey.new
    journey.entry_station = "Victoria"
    journey.exit_station = "Pimlico"
    journey.start_journey
    journey.end_journey
    expect(journey.fare).to eq(1)
  end

  it "gives a penalty charge" do
    journey = Journey.new
    journey.exit_station = "Pimlico"
    journey.end_journey
    expect(journey.fare).to eq 6
  end


end