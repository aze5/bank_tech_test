require 'date'

class BankAccount
  attr_accessor :transactions

  def initialize(kernel)
    @io = kernel
    @transactions = []
  end

  def deposit(amount, date)
    @transactions << {amount: amount, date: date}  
  end

  def withdraw(amount, date)
    @transactions << {amount: -amount, date: date}
  end


  def statement
    transactions_copy = @transactions.dup
    sorted_transactions = transactions_copy.sort_by { |t| t[:date] }
    
    balance = 0
    @io.puts "date || credit || debit || balance"
    
    transaction_strings = []

    sorted_transactions.each do |transaction|
      balance += transaction[:amount]
      if transaction[:amount] > 0
        transaction_strings << "#{transaction[:date]} || #{'%.2f' % transaction[:amount]} || || #{'%.2f' % balance}"
      else
        transaction_strings << "#{transaction[:date]} || || #{'%.2f' % -transaction[:amount]} || #{'%.2f' % balance}"
      end
    end
    transaction_strings.reverse_each do |t|
      @io.puts t
    end
  end
end

# account = BankAccount.new(Kernel)

# account.withdraw(500, "14/01/2021")
# account.deposit(2000, "15/01/2021")
# account.deposit(1000, "10/01/2021")
# account.statement