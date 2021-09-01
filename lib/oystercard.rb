class Oystercard
  MAXIMUM_AMOUNT = 90
  MINIMUM_AMOUNT = 1

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
    raise "Cannot touch in: balance is below #{MINIMUM_AMOUNT}" if @balance < MINIMUM_AMOUNT  
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