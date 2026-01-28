class BankAccount{
  double balance = 0;
  deposit(double amount){
    balance += amount;
  }
  withdraw(double amount){
    if (amount <= balance){
      balance -= amount;
    }else{
      print('Insufficient balance');
    }
  }
}

void main() {
  BankAccount account = BankAccount();
  account.deposit(1000);
  print('Balance after deposit: ${account.balance}');
  account.withdraw(30);
  print('Balance after withdrawal: ${account.balance}');
}

