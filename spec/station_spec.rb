require 'station'

describe Station do
  subject { described_class.new("Euston", 2) } 
  # walkthrough version: subject { described_class.new(name: "Euston", zone: 2) }
  # why does this not work? 

  it 'it know its name' do
    expect(subject.name).to eq("Euston")
  end

  it 'it knows its zone' do
    expect(subject.zone).to eq(2)
  end
end