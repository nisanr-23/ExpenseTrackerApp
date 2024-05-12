import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Transaction {
  final double amount;
  final String type;
  final DateTime dateTime;

  Transaction({required this.amount, required this.type, required this.dateTime});
}

class TransactionHistoryPage extends StatefulWidget {
  final SharedPreferences prefs;

  const TransactionHistoryPage({Key? key, required this.prefs}) : super(key: key);

  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    // Retrieve and parse transaction data from SharedPreferences
    final List<String>? transactionStrings = widget.prefs.getStringList('transactions');
    if (transactionStrings != null) {
      setState(() {
        transactions = transactionStrings
            .map((transactionString) {
          final parts = transactionString.split('|');
          return Transaction(
            amount: double.parse(parts[0]),
            type: parts[1],
            dateTime: DateTime.parse(parts[2]),
          );
        })
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent.shade700,
        title: Text('Transaction History',style: TextStyle(color: Colors.white),),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              tileColor: Colors.redAccent.shade200,
              title: Text('${transactions[index].type}: \$${transactions[index].amount.toStringAsFixed(2)}',style: TextStyle(color: Colors.white),),
              subtitle: Text('Date: ${transactions[index].dateTime}',style: TextStyle(color: Colors.white)),
            ),
          );
        },
      ),
    );
  }
}
