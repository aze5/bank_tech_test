require "bank_account"

describe BankAccount do
  it "makes deposits with amount and date" do
    account = BankAccount.new(Kernel)
    account.deposit(1000, "01/10/2021")
    expect(account.transactions).to eq [{amount: 1000, date:"01/10/2021"}] 
  end

  it "makes withdrawals with amount and date" do
    account = BankAccount.new(Kernel)
    account.deposit(1000, "01/09/2021")
    account.withdraw(500, "01/10/2021")
    expect(account.transactions).to eq [{amount: 1000, date:"01/09/2021"}, {amount: -500, date:"01/10/2021"}] 
  end

  context "statement method" do
    it "statement prints with correct format" do
      io = double :kernel
      account = BankAccount.new(io)
      expect(io).to receive(:puts).with("date || credit || debit || balance")
      account.statement()
    end

    it "statement shows all transactions" do
      io = double :kernel
      account = BankAccount.new(io)
      account.deposit(2000, "05/10/2021")
      account.deposit(1000, "01/10/2021")
      account.withdraw(500, "06/10/2021")
      expect(io).to receive(:puts).with("date || credit || debit || balance")
      expect(io).to receive(:puts).with("06/10/2021 || || 500.00 || 2500.00")
      expect(io).to receive(:puts).with("05/10/2021 || 2000.00 || || 3000.00")
      expect(io).to receive(:puts).with("01/10/2021 || 1000.00 || || 1000.00")
      account.statement()
    end
  end
  context "edge cases" do
    it "does not change balance after depositing zero amount" do
      io = double :kernel
      account = BankAccount.new(io)
      account.deposit(2000, "05/09/2021")
      account.deposit(0, "01/10/2021")
      expect(io).to receive(:puts).with("date || credit || debit || balance")
      expect(io).to receive(:puts).with("01/10/2021 || || 0.00 || 2000.00")
      expect(io).to receive(:puts).with("05/09/2021 || 2000.00 || || 2000.00")
      account.statement
    end
  
    it "does not change balance after withdrawing zero amount" do        account = BankAccount.new(Kernel)
      io = double :kernel
      account = BankAccount.new(io)
      account.deposit(2000, "05/09/2021")
      account.withdraw(0, "01/10/2021")
      expect(io).to receive(:puts).with("date || credit || debit || balance")
      expect(io).to receive(:puts).with("01/10/2021 || || 0.00 || 2000.00")
      expect(io).to receive(:puts).with("05/09/2021 || 2000.00 || || 2000.00")
      account.statement
    end
  
    it "raises error after depositing negative amount" do
      account = BankAccount.new(Kernel)
      expect{ account.deposit(-1000, "01/10/2021") }.to raise_error("Please enter an amount above zero")
    end
  
    it "raises error after withdrawing negative amount" do
      account = BankAccount.new(Kernel)
      expect{ account.withdraw(-500, "02/10/2021") }.to raise_error("Please enter an amount above zero")
    end
  
    it "does not allow withdrawing more than the balance" do
      account = BankAccount.new(Kernel)
      account.deposit(1000, "01/10/2021")
      expect{ account.withdraw(2000, "02/10/2021") }.to raise_error("INSUFFICIENT FUNDS")
    end
  end
end
  
