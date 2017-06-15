require 'station.rb'

describe Station do

  let(:station) { described_class.new("Bank", 2) }

  describe "#initialize" do
  it 'initializes with a name' do
    expect(station.name).to eq("Bank")
  end
  it 'initializes with a zone' do
    expect(station.zone).to eq(2)
  end
end

end
