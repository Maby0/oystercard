class Oystercard
  MAXIMUM_AMOUNT = 90

  attr_reader :balance, :in_journey

  def initialize 
    @balance = 0
    @in_journey = false
    # @count = []
  end

  def top_up(value)
    raise "Balance cannot exceed #{MAXIMUM_AMOUNT}" if (@balance + value) > MAXIMUM_AMOUNT
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  # def count
  #   count += 1
  #   @count << count
  # end 

end