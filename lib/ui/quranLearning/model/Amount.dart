class Amount{
  String? amount,
  date;

  Amount({
    this.amount,
    this.date
  });

  factory Amount.fromAmountJson(Map<String, String> json) {
    return Amount(
        amount:json['amount'] ?? '',
        date: json['date'] ?? '',
    );
  }
}