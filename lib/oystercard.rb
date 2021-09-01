class Oystercard
  MAXIMUM_AMOUNT = 90

  attr_reader :balance

  def initialize 
    @balance = 0
    # @count = []
  end

  def top_up(value)
    raise "Balance cannot exceed #{MAXIMUM_AMOUNT}" if (@balance + value) > MAXIMUM_AMOUNT
    @balance += value
  end

  # def count
  #   count += 1
  #   @count << count
  # end 

end