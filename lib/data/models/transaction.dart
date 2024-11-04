class Transaction {
  final double amount;
  final DateTime date;
  final String description;
  final String type;

  Transaction({
    required this.amount,
    required this.date,
    required this.description,
    required this.type,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      amount: (json['amount'] is String)
          ? double.parse(json['amount']) // Parse if it's a string
          : json['amount'] as double, // Use directly if it's already a double
      date: DateTime.parse(json['date']),
      description: json['description'],
      type: json['type'],
    );
  }
}
