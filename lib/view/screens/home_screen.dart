import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/provider/expense_provider.dart';
import '../widgets/receipt_card.dart';
import 'add_receipt_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Expense Vault")),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: const Text("Total Expense"),
              subtitle: Text("₹ ${provider.totalExpense}"),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: provider.receipts.length,
              itemBuilder: (_, index) {
                return ReceiptCard(provider.receipts[index]);
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddReceiptScreen()),
          );
        },
      ),
    );
  }
}
