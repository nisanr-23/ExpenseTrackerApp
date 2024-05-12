import 'package:flutter/material.dart';

class AddIncomePage extends StatelessWidget {
  final Function(double) onIncomeAdded;

  const AddIncomePage({Key? key, required this.onIncomeAdded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double incomeAmount = 0.0;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent.shade400,
        title: Text('Add Income',style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter Income Amount:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                incomeAmount = double.tryParse(value) ?? 0.0;
              },
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (incomeAmount > 0) {
                  onIncomeAdded(incomeAmount);
                  Navigator.pop(context);
                }
              },
              child: Text('Add Income'),
            ),
          ],
        ),
      ),
    );
  }
}
