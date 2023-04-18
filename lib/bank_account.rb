require "date"

class BankAccount
  attr_accessor :transactions

  # Initialize BankAccount with an IO object for mocking
  def initialize(kernel)
    @io = kernel
    @transactions = []
  end

  def deposit(amount, date)
    more_than_zero?(amount)
    @transactions << {amount: amount, date: date}  
  end

  def more_than_zero?(amount)
    if amount < 0 
      raise("Please enter an amount above zero")
    end
  end
  
  def calculate_balance
    @transactions.sum{ |t| t[:amount] } 
  end

  def withdraw(amount, date)
    more_than_zero?(amount)
    balance = calculate_balance()
    if amount > balance
      raise("INSUFFICIENT FUNDS")
    else
      @transactions << {amount: -amount, date: date}
    end
  end

  # Format transaction string based on transaction type (deposit or withdrawal)
  def format_transaction_string(transaction, balance)
    if transaction[:amount] > 0
      return "#{transaction[:date]} || #{'%.2f' % transaction[:amount]} || || #{'%.2f' % balance}"
    else
      return "#{transaction[:date]} || || #{'%.2f' % -transaction[:amount]} || #{'%.2f' % balance}"
    end
  end

  # Print a statement of all transactions in the account
  def statement
    # Create a copy of the transactions array so we don't modify the original
    transactions_copy = @transactions.dup
    sorted_transactions = transactions_copy.sort_by { |t| DateTime.parse(t[:date]) }
    
    @io.puts "date || credit || debit || balance"

    # Create an array to hold formatted transaction strings
    transaction_strings = []
    balance = 0
    sorted_transactions.each do |transaction|
      balance += transaction[:amount]
      transaction_strings << format_transaction_string(transaction, balance)
    end
    
    # Print transaction strings in reverse order (latest transactions first)
    transaction_strings.reverse_each do |t|
      @io.puts t
    end
  end
end

account = BankAccount.new(Kernel)
account.deposit(2000, "05/10/2021")
account.deposit(1000, "01/10/2021")
account.withdraw(500, "06/10/2021")
account.statement