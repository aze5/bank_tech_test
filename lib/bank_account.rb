class BankAccount
  def initialize(kernel)
    @io = kernel
    @transactions = []
  end

  def statement
    @io.puts "date || credit || debit || balance"
  end
  
end