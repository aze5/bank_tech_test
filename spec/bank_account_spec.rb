require "bank_account"

describe BankAccount do
  it "statement prints with correct format" do
    io = double :kernel
    account = BankAccount.new(io)
    expect(io).to receive(:puts).with("date || credit || debit || balance")
    account.statement()
  end

  it "makes deposits with amount and date" do
    account = BankAccount.new(Kernel)
    account.deposit(1000, "01/10/2021")
    expect(account.transactions).to eq [{amount: 1000, date:"01/10/2021"}] 
  end

  it "makes withdrawals with amount and date" do
    account = BankAccount.new(Kernel)
    account.withdraw(500, "01/10/2021")
    expect(account.transactions).to eq [{amount: -500, date:"01/10/2021"}] 
  end

  it "statement shows with all transactions" do
    io = double :kernel
    account = BankAccount.new(io)
    account.deposit(1000, "01/10/2021")
    account.deposit(2000, "05/10/2021")
    account.withdraw(500, "06/10/2021")
    expect(io).to receive(:puts).with("date || credit || debit || balance")
    expect(io).to receive(:puts).with("06/10/2021 || || 500.00 || 2500.00")
    expect(io).to receive(:puts).with("05/10/2021 || 2000.00 || || 3000.00")
    expect(io).to receive(:puts).with("01/10/2021 || 1000.00 || || 1000.00")
    account.statement()
  end
end