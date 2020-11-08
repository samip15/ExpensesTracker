import 'dart:io';

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
                fontSize: 20),
          ),
        ),
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
  List<Transaction> _txList = [];
  bool _showChart = false;
  List<Transaction> get _recentTransaction {
    return _txList.where(
      (tx) {
        return tx.transaction_date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  /// Function {__addTx} : Adds A New Transaction
  void _addTx(String itemName, double itemPrice, DateTime itemDate) {
    setState(
      () {
        _txList.add(
          Transaction(
            name: itemName,
            price: itemPrice,
            transaction_date: itemDate,
            id: itemDate.toString(),
          ),
        );
      },
    );
  }

  /// Function {_deleteTx} : Deletes A  Transaction
  void _deleteTx(String id) {
    setState(
      () {
        _txList.removeWhere(
          (trans) {
            return trans.id == id;
          },
        );
      },
    );
  }

  /// Model Bottom Sheet
  void _showModel() {
    showModalBottomSheet(
      context: context,
      builder: (bCtx) {
        return AddTransection(
          addTransaction: _addTx,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
    PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("Expenses Tracker"),
            trailing: IconButton(
              icon: Icon(CupertinoIcons.add),
              onPressed: _showModel,
            ),
          )
        : AppBar(
            title: Text("Expenses Tracker"),
            centerTitle: true,
          );
    final txListWidget = Container(
      height: (mediaQuery.size.height * 0.7 -
          appBar.preferredSize.height -
          mediaQuery.padding.top),
      child: TransactionList(
        txList: _txList,
        deleteTx: _deleteTx,
      ),
    );

    final pageBody = Column(
      children: [
        if (isLandScape)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Show Chart"),
              Switch.adaptive(
                value: _showChart,
                onChanged: (val) {
                  setState(
                    () {
                      _showChart = val;
                    },
                  );
                },
              ),
            ],
          ),
        if (isLandScape)
          _showChart
              ? Container(
                  height: (mediaQuery.size.height * 0.7 -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top),
                  child: Chart(_recentTransaction),
                )
              : txListWidget,
        if (!isLandScape)
          Container(
            height: (mediaQuery.size.height * 0.3 -
                appBar.preferredSize.height -
                mediaQuery.padding.top),
            child: Chart(_recentTransaction),
          ),
        if (!isLandScape) txListWidget,
      ],
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: FloatingActionButton(
              onPressed: _showModel,
              child: Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
