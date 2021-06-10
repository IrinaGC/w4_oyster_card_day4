require "./lib/oyster"

describe Oyster do

  # let(:station) { Station.new }
  it "balance of 0" do
    expect(subject.balance).to eq(0)
  end

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }
    it "top up card" do
      expect{subject.top_up(2)}.to change(subject, :balance).by(2)
    end
    it "gives an error if card reaches max balance" do
      max_balance = Oyster::MAX_BALANCE
      subject.top_up(max_balance)
      expect{subject.top_up(1)}.to raise_error "Oh no! You reached the max balance"
    end
  end

  describe "#deduct" do
    it { is_expected.to respond_to(:deduct).with(1).argument }
    it "deducts money" do
      subject.top_up(10)
      expect(subject.deduct(3)).to eq 7
    end
  end

  it { is_expected.to respond_to(:touch_out) }
  it { is_expected.to respond_to(:in_journey?) }

  describe "#touch_in" do
    let(:entry_station){ double :station }
    it { is_expected.to respond_to(:touch_in) }
    it "touches in" do
      allow(subject).to receive(:balance).and_return 10
      expect(subject.touch_in(entry_station)).to eq(true)
    end
    it "raises an error if card under £1" do
      allow(subject).to receive(:balance).and_return 0.5
      expect{subject.touch_in(entry_station)}.to raise_error "Ops! Top it up!"
    end
    it "stores the entry station" do
      # entry_station = double(:entry_station)
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect( subject.entry_station ).to eq(entry_station)
    end
  end

describe "#touch_out" do
  let(:entry_station){ double :station }
  let(:exit_station){ double :station }
  it "touches out" do
    allow(subject).to receive(:balance).and_return 10
    expect(subject.touch_out(exit_station)).to eq(nil)
  end

  it "saves current journey history" do
    expect(subject.journey_history).to be_instance_of(Array)
  end

  it "stores at touch out the current journey history" do
    subject.top_up(10)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journey_history).to eq([{:entry => entry_station, :exit => exit_station}])
  end

  it "stores the exit station" do
    subject.top_up(10)
    subject.touch_out(exit_station)
    expect( subject.exit_station ).to eq(exit_station)
  end

  it "forgets the entry station" do
    subject.top_up(10)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.entry_station).to eq(nil)
  end

  it "check if in journey" do
    allow(subject).to receive(:balance).and_return 10
    subject.touch_in(entry_station)
    expect(subject.in_journey?).to eq true
  end

  it "check if not in journey" do
    allow(subject).to receive(:balance).and_return 10
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject).not_to be_in_journey
  end

  it "charges the card when you touch out" do
    expect{ subject.touch_out(exit_station) }.to change(subject, :balance).by(-1)
  end

  it "stores at touch out the current journey history" do
    subject.top_up(10)
    subject.touch_in("Kings Cross")
    subject.touch_out("Victoria")
    expect(subject.journey_history).to eq([{:entry => "Kings Cross", :exit => "Victoria"}])
  end

end
  # expect{subject.top_up(2)}.to change(subject, :balance).by(2)
end
