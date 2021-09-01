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

  describe '#deduct(value)' do
    it 'deducts money from balance' do
      oystercard.top_up(20)
      expect { oystercard.deduct(1) }.to change { oystercard.balance }.by(-1)
    end
  end

  describe '#in_journey?, #touch_in, #touch_out' do
    it 'responds to #in_journey?' do
      expect(oystercard.in_journey).to eq false
      # expect(oystercard).not_to be_in_journey
    end

    it '#touch_in is expected to change #in_journey to true' do
      oystercard.touch_in
      expect(oystercard.in_journey).to eq true
    end

    it '#touch_out is expected to change #in_journey to false' do
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard.in_journey).to eq false
    end
  end
end