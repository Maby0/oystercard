require 'oystercard'

describe Oystercard do
  let (:oystercard) { described_class.new }
  let (:entry_station) { double :station }
  let (:exit_station) { double :station }

  describe 'initialize' do
    it 'has an empty list of journeys by default' do
      expect(subject.journeys).to be_empty
    end
  end

  describe '#top_up(value)' do
    it 'adds money to card' do
      expect { oystercard.top_up(1) }.to change { oystercard.balance }.by(1)
    end 

    it 'raises an error when the card balance is above 90' do
      oystercard.top_up(Oystercard::MAXIMUM_AMOUNT)
      expect { oystercard.top_up(Oystercard::MINIMUM_AMOUNT) }.to raise_error "Balance cannot exceed #{Oystercard::MAXIMUM_AMOUNT}"
    end
  end

  describe '#in_journey?, #touch_in, #touch_out' do
    it 'new initialized cards should not be #in_journey?' do
      expect(oystercard).not_to be_in_journey
    end

    it 'raises an error when the balance is below 1, when touch_in is called' do
      expect { oystercard.touch_in(entry_station) }.to raise_error "Cannot touch in: balance is below #{Oystercard::MINIMUM_AMOUNT}"
    end

    context 'when card needs to be topped_up' do
      before(:each) do
        oystercard.top_up(20)
      end

      it '#touch_in is expected to change #in_journey to true' do
        oystercard.touch_in(entry_station)
        expect(oystercard).to be_in_journey
      end

      it '#touch_in remembers the entry_station' do
        oystercard.touch_in(entry_station)
        expect(oystercard.current_journey[:entry_station]).to eq(entry_station)
      end

      context 'when already in journey' do
        before(:each) do
          oystercard.touch_in(entry_station)
        end

        it '#touch_out is expected to change #in_journey to false' do
          oystercard.touch_out(exit_station)
          expect(oystercard).not_to be_in_journey
        end

        it '#touch_out is expected to store the exit station' do
          oystercard.touch_out(exit_station)
          expect(oystercard.current_journey[:exit_station]).to eq exit_station
        end

        it '#touch_out deducts funds from current balance' do
          # doesn't raise an error yet if #touch_out is called before calling #touch_in
          expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }.by(-Oystercard::MINIMUM_CHARGE)
        end
      end

      context 'when journeys are completed' do
        let(:current_journey) { {entry_station: entry_station, exit_station: exit_station} }

        it 'stores a journey' do
          oystercard.touch_in(entry_station)
          oystercard.touch_out(exit_station)
          expect(oystercard.journeys).to include current_journey
        end
      end
    end
  end
end
