import 'package:flutter/material.dart';
import '../models/expense.dart';

class AddExpenseScreen extends StatelessWidget {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final Function(Expense) onAddExpense;
  final String selectedCategory;

  AddExpenseScreen({required this.onAddExpense, required this.selectedCategory});

  void addExpense(BuildContext context) {
    // Permite amount să fie 0.0 dacă utilizatorul nu introduce nimic sau o valoare incorectă
    final double amount = double.tryParse(amountController.text) ?? 0.0;
    final String date = dateController.text.isNotEmpty ? dateController.text : 'No date provided';
    final String description = descriptionController.text.isNotEmpty ? descriptionController.text : 'No description provided';

    // Nu mai impunem validarea strictă, doar afișăm un mesaj informativ dacă amount e 0
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('The amount is set to 0, please check if this is intended.')),
      );
    }

    final Expense newExpense = Expense(
      type: selectedCategory,
      date: date,
      amount: amount,
      description: description,
    );

    onAddExpense(newExpense);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
        iconTheme: IconThemeData(color: Colors.green[600]), // Sageata verde
        centerTitle: true, // Pentru a centra titlul
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: "Cost",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: "Date",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    //dateController.text =
                    //"${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";

                    dateController.text = pickedDate != null
                        ? "${pickedDate!.day}-${pickedDate!.month}-${pickedDate!.year}"
                        : '';

                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addExpense(context),
        backgroundColor: Colors.green[600],
        child: Icon(Icons.check, color: Colors.black),
      ),
    );
  }
}
