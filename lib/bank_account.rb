class BankAccount
  attr_accessor :transactions

  def initialize(kernel)
    @io = kernel
    @transactions = []
  end

  def deposit(amount, date)
    @transactions << {amount: amount, date: date}  
  end


  def statement
    @io.puts "date || credit || debit || balance"
  end
  
end