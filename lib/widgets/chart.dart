import 'package:expenses_app/model/transection.dart';
import 'package:expenses_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransaction = [];

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedExpenses {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        double totalSum = 0.0;
        recentTransaction.forEach(
          (tx) {
            if (tx.transaction_date.day == weekDay.day &&
                tx.transaction_date.month == weekDay.month &&
                tx.transaction_date.year == weekDay.year) {
              totalSum += tx.price;
            }
          },
        );
        return {
          "day": DateFormat.E().format(weekDay),
          "amount": totalSum,
        };
      },
    ).reversed.toList();
  }

  double get totalSpending {
    return groupedExpenses.fold(
      0.0,
      (sum, item) {
        return sum + item["amount"];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedExpenses
              .map(
                (data) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    weekDay: data["day"],
                    dayAmount: data["amount"],
                    spentPercentage: totalSpending == 0.0
                        ? 0.0
                        : (data["amount"] as double) / totalSpending,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
