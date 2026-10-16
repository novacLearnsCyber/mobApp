class BankAccount {
  late String accountNumber;
  final String holderName;
  double balance;
  String? bankBranch;
  bool _initialized = false;

  BankAccount({
    required this.holderName,
    this.balance = 0.0,
    this.bankBranch,
  });

  void initializeAccount(String number) {
    accountNumber = number;
    _initialized = true;
  }

  bool get isInitialized => _initialized;

  String get displayNumber =>
      _initialized ? accountNumber : 'Account number not set';
}