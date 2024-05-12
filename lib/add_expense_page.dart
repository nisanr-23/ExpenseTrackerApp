import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddExpensePage extends StatelessWidget {
  final Function(double) onExpenseAdded;
  final SharedPreferences prefs;

  const AddExpensePage({Key? key, required this.onExpenseAdded, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double expenseAmount = 0.0;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent.shade200,
        title: Text('Add Expense',style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter Expense Amount:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Container(
              width: 600,
              child: TextFormField(

                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  expenseAmount = double.tryParse(value) ?? 0.0;
                },
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (expenseAmount > 0) {
                  onExpenseAdded(expenseAmount);
                  // Save transaction data to SharedPreferences
                  _saveTransaction(expenseAmount, 'Expense');
                  Navigator.pop(context);
                }
              },
              child: Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveTransaction(double amount, String type) {
    // Get the current date and time
    DateTime now = DateTime.now();
    // Save transaction data to SharedPreferences
    List<String> transactions = prefs.getStringList('transactions') ?? [];
    transactions.add('$amount|$type|$now');
    prefs.setStringList('transactions', transactions);
  }
}
