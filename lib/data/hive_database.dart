import 'package:expense_tracker/data/expense_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/expense_item.dart';

class HiveDatabase {
  //Reference our DB
  final _myBox = Hive.box("expense_database");
  //Write data
  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allExpenseFormatted = [];

    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpenseFormatted.add(expenseFormatted);
    }
    _myBox.put("ALL_EXPENSES", allExpenseFormatted);
  }

  //Read data
  List<ExpenseItem> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      ExpenseItem expense = ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );

      allExpenses.add(expense);
    }

    return allExpenses;
  }
}
