class ReceiptModel {
  String id;
  String imagePath;
  double amount;
  DateTime date;
  String category;
  String notes;

  ReceiptModel({
    required this.id,
    required this.imagePath,
    required this.amount,
    required this.date,
    required this.category,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category,
      'notes': notes,
    };
  }

  factory ReceiptModel.fromMap(Map<String, dynamic> map) {
    return ReceiptModel(
      id: map['id'],
      imagePath: map['imagePath'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      category: map['category'],
      notes: map['notes'],
    );
  }
}
