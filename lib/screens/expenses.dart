import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'add_expenses.dart';
import 'expense_category.dart';

class ExpensesScreen extends StatefulWidget {
  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<String> _categories = [
    'Insurance',
    'Technical Review',
    'Road Tax',
    'Oil & Filter Change',
    'Fuel',
    'Repairs',
    'Others'
  ];

  // Mapa pentru a stoca cheltuielile pe categorii
  final Map<String, List<Expense>> _expensesByCategory = {
    'Insurance': [],
    'Technical Review': [],
    'Road Tax': [],
    'Oil & Filter Change': [],
    'Fuel': [],
    'Repairs': [],
    'Others': [],
  };

  void _addNewExpense(Expense expense, String category) {
    setState(() {
      _expensesByCategory[category]?.add(expense);
    });
  }

  void _startAddNewExpense(BuildContext context, String category) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return AddExpenseScreen(
          selectedCategory: category,
          onAddExpense: (expense) => _addNewExpense(expense, category),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  leading: Icon(
                    _getCategoryIcon(_categories[index]),
                    color: Colors.green[600], // Verde
                  ),
                  title: Text(_categories[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CategoryDetailScreen(
                            category: _categories[index],
                            expenses: _expensesByCategory[_categories[index]] ?? [],
                            onAddExpense: (expense) => _addNewExpense(expense, _categories[index]),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Insurance':
        return Icons.security; // Asigurare
      case 'Technical Review':
        return Icons.build; // Revizie tehnică
      case 'Road Tax':
        return Icons.money; // Taxă rutieră
      case 'Oil & Filter Change':
        return Icons.opacity; // Schimb de ulei
      case 'Fuel':
        return Icons.local_gas_station; // Combustibil
      case 'Repairs':
        return Icons.handyman; // Reparatii
      case 'Others':
        return Icons.notes; // Alte cheltuieli
      default:
        return Icons.error; // Iconă de eroare pentru categorii necunoscute
    }
  }
}