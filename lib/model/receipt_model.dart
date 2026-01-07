import 'package:hive/hive.dart';

part 'receipt_model.g.dart';

@HiveType(typeId: 0)
class ReceiptModel extends HiveObject {

  @HiveField(0)
  String id;

  @HiveField(1)
  String imagePath;

  @HiveField(2)
  double amount;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  String category;

  @HiveField(5)
  String notes;

  ReceiptModel({
    required this.id,
    required this.imagePath,
    required this.amount,
    required this.date,
    required this.category,
    required this.notes,
  });
}
