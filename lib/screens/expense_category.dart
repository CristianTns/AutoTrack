import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'add_expenses.dart';
import '../services/api_service.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String category;
  final List<Expense> expenses;
  final Function(Expense) onAddExpense;

  CategoryDetailScreen({
    required this.category,
    required this.expenses,
    required this.onAddExpense,
  });

  void _startAddNewExpense(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return AddExpenseScreen(
          selectedCategory: category,
          onAddExpense: (expense) {
            onAddExpense(expense);
            Navigator.of(ctx).pop(); // Întoarce utilizatorul la pagina anterioară
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$category Expenses"),
        backgroundColor: Colors.blue[800],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: expenses.isEmpty
            ? Center(
          child: Text(
            "No expenses in this category.",
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
        )
            : ListView.builder(
          itemCount: expenses.length,
          itemBuilder: (ctx, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(
                  expenses[index].description,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Cost: ${expenses[index].amount} \nDate: ${expenses[index].date}",
                  style: TextStyle(color: Colors.grey[700]),
                ),
                trailing: Icon(
                  Icons.attach_money,
                  color: Colors.green[600],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewExpense(context),
        backgroundColor: Colors.green[600],
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
