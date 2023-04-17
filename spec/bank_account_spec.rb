require "bank_account"

describe BankAccount do
  it "statement prints with correct format" do
    io = double :kernel
    account = BankAccount.new(io)
    expect(io).to receive(:puts).with("date || credit || debit || balance")
    account.statement()
  end

  # it "makes deposits with time and date" do
  #   account = BankAccount.new()
  #   account.deposit()
  # end
end