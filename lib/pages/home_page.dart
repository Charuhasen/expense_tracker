import 'package:expense_tracker/components/expense_summary.dart';
import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Text Controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseDollarAmountController = TextEditingController();
  final newExpenseCentsAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
        ),
        body: ListView(
          children: [
            ExpenseSummary(startOfWeek: value.startOfTheWeek()),
            const SizedBox(
              height: 30,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) => ExpenseTile(
                  name: value.getAllExpenseList()[index].name,
                  amount: value.getAllExpenseList()[index].amount,
                  dateTime: value.getAllExpenseList()[index].dateTime),
            ),
          ],
        ),
      ),
    );
  }

  void addNewExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Add new expense"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Expense name
                  TextField(
                    controller: newExpenseNameController,
                    decoration: const InputDecoration(hintText: "Expense Name"),
                  ),
                  //Expense amount
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: newExpenseDollarAmountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: "Dollars"),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: newExpenseCentsAmountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: "Cents"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                //Save Button
                MaterialButton(
                  onPressed: save,
                  child: const Text("Save"),
                ),
                //Cancel Button
                MaterialButton(
                  onPressed: cancel,
                  child: const Text("Cancel"),
                ),
              ],
            ));
  }

  void save() {
    //Put the Dollar and Cents amount together
    String amount =
        "${newExpenseDollarAmountController.text}.${newExpenseCentsAmountController.text}";
    //Add expense item
    ExpenseItem expenseItem = ExpenseItem(
      name: newExpenseNameController.text,
      amount: amount,
      dateTime: DateTime.now(),
    );

    Provider.of<ExpenseData>(context, listen: false).addNewExpense(expenseItem);
    Navigator.pop(context);
    clearController();
  }

  void cancel() {
    Navigator.pop(context);
    clearController();
  }

  void clearController() {
    newExpenseNameController.clear();
    newExpenseDollarAmountController.clear();
    newExpenseCentsAmountController.clear();
  }
}
