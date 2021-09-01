require 'oystercard'

describe Oystercard do
  subject (:oystercard) { described_class.new }

  it 'checks new card has a balance' do
    expect(oystercard.balance).to eq(0)
  end

  describe '#top_up(value)' do
    it 'adds money to card' do
      # expect(oystercard).to respond_to(:top_up).with(1).argument
      expect { oystercard.top_up(1) }.to change { oystercard.balance }.by(1)
    end 

    it 'raises an error when the card balance is above 90' do
      oystercard.top_up(90)
      expect { oystercard.top_up(1) }.to raise_error "Balance cannot exceed #{Oystercard::MAXIMUM_AMOUNT}"
    end 
  end
end       