import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../controller/provider/expense_provider.dart';

class AddReceiptScreen extends StatefulWidget {
  const AddReceiptScreen({super.key});

  @override
  State<AddReceiptScreen> createState() => _AddReceiptScreenState();
}

class _AddReceiptScreenState extends State<AddReceiptScreen> {

  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedCategory = "General";
  File? _imageFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? picked =
        await _picker.pickImage(source: ImageSource.camera);

    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  void _saveReceipt() async {

    if (_imageFile == null ||
        _amountController.text.isEmpty) {
      return;
    }

    double amount =
        double.parse(_amountController.text);

    await context.read<ExpenseProvider>().addReceipt(
          _imageFile!.path,
          amount,
          _selectedCategory,
          _notesController.text,
        );

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Add Receipt")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [

            GestureDetector(
              onTap: _pickImage,
              child: Card(
                child: Container(
                  height: 200,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: _imageFile == null
                      ? const Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt,
                                size: 40),
                            Text("Tap to scan")
                          ],
                        )
                      : Image.file(_imageFile!,
                          fit: BoxFit.cover),
                ),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: _amountController,
              keyboardType:
                  TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                    value: "General",
                    child: Text("General")),
                DropdownMenuItem(
                    value: "Food",
                    child: Text("Food")),
                DropdownMenuItem(
                    value: "Travel",
                    child: Text("Travel")),
                DropdownMenuItem(
                    value: "Shopping",
                    child: Text("Shopping")),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedCategory =
                      value ?? "General";
                });
              },
            ),

            const SizedBox(height: 10),

            TextField(
              controller: _notesController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: "Notes",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: _saveReceipt,
              child: const Text("Save Receipt"),
            )
          ],
        ),
      ),
    );
  }
}
