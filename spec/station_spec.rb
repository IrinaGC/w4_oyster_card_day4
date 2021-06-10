require "station"

describe Station do

  it "knows its name" do
    station = Station.new("Victoria", 1)
    expect(station.name).to eq("Victoria")
  end

  it "knows its zone" do
    station = Station.new("Victoria", 1)
    expect(station.zone).to eq(1)
  end

end