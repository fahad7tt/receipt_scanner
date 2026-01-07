import 'package:flutter/material.dart';
import 'package:receipt_scanner/app.dart';
import 'controller/services/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalStorageService().initHive();

  runApp(const MyApp());
}
