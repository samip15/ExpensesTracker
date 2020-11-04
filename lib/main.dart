import 'package:expenses_app/model/transection.dart';
import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/new_transection.dart';
import 'package:expenses_app/widgets/transection_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.brown,
        accentColor: Colors.green,
        fontFamily: "SourceCodePro",
        appBarTheme: AppBarTheme(
            textTheme: TextTheme(
                headline6: TextStyle(
                    fontFamily: "TurretRoad",
                    fontWeight: FontWeight.bold,
                    fontSize: 20))),
      ),
      home: ExpensePage(),
    );
  }
}

class ExpensePage extends StatefulWidget {
  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  List<Transaction> _txList = [
    Transaction(
        name: "Watch",
        price: 900.0,
        transaction_date: DateTime.now(),
        id: DateTime.now().toString()),
    Transaction(
        name: "Shirt",
        price: 300.0,
        transaction_date: DateTime.now(),
        id: DateTime.now().toString()),
  ];

  /// Function {__addTx} : Adds A New Transaction
  void _addTx(String itemName, double itemPrice, DateTime itemDate) {
    setState(() {
      _txList.add(Transaction(
          name: itemName,
          price: itemPrice,
          transaction_date: itemDate,
          id: itemDate.toString()));
    });
  }

  /// Function {_deleteTx} : Deletes A  Transaction
  void _deleteTx(String id) {
    setState(() {
      _txList.removeWhere((trans) {
        return trans.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses Tracker"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ChartBar(),
          SizedBox(
            height: 20,
          ),
          TransactionList(
            txList: _txList,
            deleteTx: _deleteTx,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (bCtx) {
                return AddTransection(
                  addTransaction: _addTx,
                );
              });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
