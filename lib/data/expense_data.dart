import 'package:expense_tracker/datetime/date_time_helper.dart';
import 'package:expense_tracker/models/expense_item.dart';

class ExpenseData {
  //List all expenses
  List<ExpenseItem> overAllExpenseList = [];
  //Get expenses
  List<ExpenseItem> getAllExpenseList() {
    return overAllExpenseList;
  }

  //Add new expenses
  void addNewExpense(ExpenseItem newExpense) {
    overAllExpenseList.add(newExpense);
  }

  //Delete expenses
  void deleteExpense(ExpenseItem expenseItem) {
    overAllExpenseList.remove(expenseItem);
  }

  //Get weekday from DateTime object
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  //Get date for the start of the week
  DateTime startOfTheWeek() {
    DateTime? startOfWeek;

    //Get todays date
    DateTime today = DateTime.now();

    //Go backwards from today to find sunday
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  /*
  Convert overall list into a daily expense summary 
  */
  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {
      //
    };
    for (var expense in overAllExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}
