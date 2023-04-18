require "date"

class BankAccount
  attr_accessor :transactions

  # Initialize BankAccount with an IO object for mocking
  def initialize(kernel)
    @io = kernel
    @transactions = []
  end

  def deposit(amount, date)
    if amount < 0 
      raise("Please enter an amount above zero")
    end
    @transactions << {amount: amount, date: date}  
  end

  def withdraw(amount, date)
    if amount < 0
      raise("Please enter an amount above zero")
    end
    balance = 0
    @transactions.each do |t|
      balance += t[:amount]
    end
    if amount > balance
      raise("INSUFFICIENT FUNDS")
    else
      @transactions << {amount: -amount, date: date}
    end
  end

  # Print a statement of all transactions in the account
  def statement
    # Create a copy of the transactions array so we don't modify the original
    transactions_copy = @transactions.dup
    sorted_transactions = transactions_copy.sort_by { |t| DateTime.parse(t[:date]) }
    
    balance = 0
    @io.puts "date || credit || debit || balance"
    
    # Create an array to hold formatted transaction strings
    transaction_strings = []

    sorted_transactions.each do |transaction|
      balance += transaction[:amount]

      # Format transaction string based on transaction type (deposit or withdrawal)
      if transaction[:amount] > 0
        transaction_strings << "#{transaction[:date]} || #{'%.2f' % transaction[:amount]} || || #{'%.2f' % balance}"
      else
        transaction_strings << "#{transaction[:date]} || || #{'%.2f' % -transaction[:amount]} || #{'%.2f' % balance}"
      end
    end

    # Print transaction strings in reverse order (latest transactions first)
    transaction_strings.reverse_each do |t|
      @io.puts t
    end
  end
end