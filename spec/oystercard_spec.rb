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

  describe '#in_journey?, #touch_in, #touch_out' do
    it 'responds to #in_journey?' do
      expect(oystercard.in_journey).to eq false
      # expect(oystercard).not_to be_in_journey
    end

    it '#touch_in is expected to change #in_journey to true' do
      oystercard.top_up(2)
      oystercard.touch_in
      expect(oystercard.in_journey).to eq true
    end

    it '#touch_out is expected to change #in_journey to false' do
      oystercard.top_up(2)
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard.in_journey).to eq false
    end
  
    it 'raises an error when the balance is below 1, when touch_in is called' do
      expect{ oystercard.touch_in }.to raise_error "Cannot touch in: balance is below #{Oystercard::MINIMUM_AMOUNT}"
    end

    it '#touch_out deducts funds from current balance' do
      minimum_fare = 1
      oystercard.top_up(20)
      expect { oystercard.touch_out }.to change { oystercard.balance }.by(-minimum_fare)
    end
  end
end