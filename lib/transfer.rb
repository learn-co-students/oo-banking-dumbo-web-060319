require 'pry'

class Transfer
  attr_accessor :sender, :receiver, :amount, :status

  @@all = []

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'

    @@all << self
  end
  
  def self.all
    @@all
  end

  def valid?
    return true if @sender.valid? and @receiver.valid?

    false
  end

  def execute_transaction
    msg = "Transaction rejected. Please check your account balance."
    if @status == 'pending'
      @sender.balance -= @amount
      @receiver.deposit(@amount)
      @status = 'complete'
    end

    if @sender.valid? == false
      @status = 'rejected'
      puts msg
      return msg 
    end

    # binding.pry
      
  end

  def reverse_transfer
    if @status == 'complete'
      @receiver.balance -= @amount
      @sender.deposit(@amount)
      @status = 'reversed'
    end
  end
end
