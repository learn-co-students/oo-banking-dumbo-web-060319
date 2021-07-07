class Transfer
@@all=[]
  attr_reader :sender, :receiver, :amount
  attr_accessor  :status

  def initialize(sender,receiver,amount)
    @sender=sender
    @receiver=receiver
    @amount=amount
    @status="pending"
    @@all<< self
  end

  def valid?
    @sender.valid? && @receiver.valid? && @sender.balance >= @amount
  end

  def execute_transaction
    if self.status !="complete"
        if valid?
            @sender.balance-=@amount
            @receiver.balance+=@amount
              @status="complete"
              return nil
        end
    end

  @status="rejected"
  return "Transaction rejected. Please check your account balance."
  end

  def reverse_transfer
    if self.status== "complete"
    @sender.balance+=@amount
    @receiver.balance-=@amount
    self.status="reversed"
  end
  end
end
