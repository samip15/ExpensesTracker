import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartBar extends StatelessWidget {
  List<Map<String, Object>> get groupedExpenses {
    return List.generate(7, (index) {
      return {
        "day": DateFormat.E().format(DateTime.now()),
        "amount": 10 * index,
      };
    });
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
                  (data) => Column(
                    children: [
                      Text("\$${data["amount"]}"),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 10,
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            color: Color.fromRGBO(220, 220, 220, 1),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("${data["day"]}")
                    ],
                  ),
                )
                .toList()),
      ),
    );
  }
}
