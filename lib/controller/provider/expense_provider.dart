import 'package:flutter/material.dart';
import '../../model/receipt_model.dart';
import '../services/local_storage_service.dart';
import 'package:uuid/uuid.dart';

class ExpenseProvider with ChangeNotifier {
  List<ReceiptModel> _receipts = [];
  final LocalStorageService _storageService = LocalStorageService();

  List<ReceiptModel> get receipts => _receipts;

  double get totalExpense =>
      _receipts.fold(0, (sum, item) => sum + item.amount);

  Future<void> loadReceipts() async {
    _receipts = _storageService.getAllReceipts();
    notifyListeners();
  }

  Future<void> addReceipt(String path, double amount, String category, String notes) async {
    var uuid = const Uuid();

    ReceiptModel receipt = ReceiptModel(
      id: uuid.v4(),
      imagePath: path,
      amount: amount,
      date: DateTime.now(),
      category: category,
      notes: notes,
    );

    await _storageService.saveReceipt(receipt);

    _receipts.add(receipt);
    notifyListeners();
  }

  Future<void> removeReceipt(String id) async {
    await _storageService.deleteReceipt(id);

    _receipts.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
