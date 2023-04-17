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
    balance = 0
    @transactions.each do |transaction|
      balance += transaction[:amount]
      if transaction[:amount] > 0 
        @io.puts "#{transaction[:date]} || #{transaction[:amount]} || || #{balance}"
      else
        @io.puts "#{transaction[:date]} || || #{-transaction[:amount]} || #{balance}"
      end
    end
  end
  
end