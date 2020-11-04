import 'package:expenses_app/model/transection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> txList;
  final Function deleteTx;

  TransactionList({@required this.txList, @required this.deleteTx});

  @override
  Widget build(BuildContext context) {
    ThemeData _themeConst = Theme.of(context);
    return Expanded(
      child: Container(
        child: ListView.builder(
            itemCount: txList.length,
            itemBuilder: (iCtx, index) {
              return Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: CircleAvatar(
                    backgroundColor: _themeConst.primaryColor,
                    child: Text(
                      "\$${txList[index].price}",
                      style: _themeConst.textTheme.subtitle1
                          .copyWith(fontSize: 14, color: Colors.white),
                    ),
                    radius: 45,
                  ),
                  title: Text(
                    txList[index].name,
                    style:
                        _themeConst.textTheme.headline6.copyWith(fontSize: 21),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMEd().format(txList[index].transaction_date),
                    style: _themeConst.textTheme.caption.copyWith(fontSize: 11),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      deleteTx(txList[index].id);
                    },
                  ),
                ),
              );
            }),
      ),
    );
  }
}
