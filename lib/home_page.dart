import 'package:flutter/material.dart';
import 'package:expense_tracker/add_expense_page.dart';
import 'package:expense_tracker/add_income_page.dart';
import 'package:expense_tracker/transaction_history_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final SharedPreferences prefs;

  const HomePage({Key? key, required this.prefs}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double totalExpenses = 0.0;
  double totalIncome = 0.0;
  List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      totalExpenses = widget.prefs.getDouble('totalExpenses') ?? 0.0;
      totalIncome = widget.prefs.getDouble('totalIncome') ?? 0.0;
      // Load transactions from shared preferences
      // transactions = ...
    });
  }

  @override
  Widget build(BuildContext context) {
    double availableBalance = totalIncome - totalExpenses;

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blueAccent.shade700,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(

              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Colors.greenAccent.shade700,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                          child: Text(
                            'Available Balance: ${availableBalance.toStringAsFixed(2)} TK.',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.yellowAccent.shade700,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                          child: Text(
                            'Total Income: ${totalIncome.toStringAsFixed(2)} TK.',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.redAccent.shade400,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                          child: Text(
                            'Total Expenses: ${totalExpenses.toStringAsFixed(2)} TK.',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),



            SizedBox(height: 40),
            Container(
              height: 30,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.redAccent.shade700,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddExpensePage(onExpenseAdded: _updateTotalExpenses, prefs: widget.prefs)),
                  );
                },
                child: Center(child: Text('Add Expense',style: TextStyle(color: Colors.white),)),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 30,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.greenAccent.shade700,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddIncomePage(onIncomeAdded: _updateTotalIncome, )),
                  );
                },
                child: Center(child: Text('Add Income',style: TextStyle(color: Colors.white),)),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 30,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.shade700,
                  borderRadius: BorderRadius.circular(10)
              ),

              child: InkWell(

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TransactionHistoryPage(prefs: widget.prefs)),
                  );
                },
                child: Center(child: Text('View Transaction History',style: TextStyle(color: Colors.white),)),
              ),
            ),

          ],
        ),
      ),
    );
  }

  void _updateTotalExpenses(double amount) {
    setState(() {
      totalExpenses += amount;
      widget.prefs.setDouble('totalExpenses', totalExpenses);
      // Save transactions to shared preferences
    });
  }

  void _updateTotalIncome(double amount) {
    setState(() {
      totalIncome += amount;
      widget.prefs.setDouble('totalIncome', totalIncome);
      // Save transactions to shared preferences
    });
  }
}
