import 'package:hive_flutter/hive_flutter.dart';
import '../../model/receipt_model.dart';

class LocalStorageService {

  static const String boxName = "receipts";

  Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ReceiptModelAdapter());
    await Hive.openBox<ReceiptModel>(boxName);
  }

  Future<void> saveReceipt(ReceiptModel receipt) async {
    var box = Hive.box<ReceiptModel>(boxName);
    await box.put(receipt.id, receipt);
  }

  List<ReceiptModel> getAllReceipts() {
    var box = Hive.box<ReceiptModel>(boxName);
    return box.values.toList();
  }

  Future<void> deleteReceipt(String id) async {
    var box = Hive.box<ReceiptModel>(boxName);
    await box.delete(id);
  }
}
