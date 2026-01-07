import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/provider/expense_provider.dart';
import '../../model/receipt_model.dart';

class ReceiptCard extends StatelessWidget {
  final ReceiptModel receipt;
  const ReceiptCard(this.receipt, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          Image.file(
            File(receipt.imagePath),
            height: 150,
          ),
          ListTile(
            title: Text("₹ ${receipt.amount}"),
            subtitle: Text(receipt.category),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context.read<ExpenseProvider>().removeReceipt(receipt.id);
              },
            ),
          )
        ],
      ),
    );
  }
}
