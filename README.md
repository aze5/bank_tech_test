# Bank Account
  - This is a Ruby program consisting of a `BankAccount` class that represents a simple bank account. The class has methods to deposit and withdraw money from the account and a statement method to print a statement of all transactions in the account.


# Class methods
  ### `initialize(kernel)`
  - Initializes a new `BankAccount` object with an `IO` object for mocking. The `@transactions` instance variable is set to an empty array.

  ### `deposit(amount, date)`
  - Adds a deposit transaction to the account's transaction history. `amount` is the amount of money being deposited and `date` is the date of the transaction. If `amount` is less than zero, an error is raised.

  ### `withdraw(amount, date)`
  - Adds a withdrawal transaction to the account's transaction history. `amount` is the amount of money being withdrawn and `date` is the date of the transaction. If `amount` is less than zero or the account balance is insufficient, an error is raised.

  ### `statement`
  - Prints a statement of all transactions in the account. Transactions are sorted by date with the latest transaction appearing first. Each transaction is displayed with the following format: `date || credit || debit || balance`

# Running the tests
  The tests for the BankAccount class are contained in the bank_account_spec.rb file. To run the tests, run the following command in the terminal:

```
rspec bank_account_spec.rb
```
# Edge cases
The tests also cover some edge cases:

- Depositing zero amount does not change the balance.
- Withdrawing zero amount does not change the balance.
- Depositing a negative amount raises an error.
- Withdrawing a negative amount raises an error.
- Withdrawing an amount more than the account balance raises an error.