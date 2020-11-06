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
    return txList.isEmpty
        ? LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
                children: [
                  Text(
                    "No Expenses have been added!",
                    style: _themeConst.textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  Image.asset(
                    "assets/images/box.png",
                    height: constraints.maxHeight * 0.6,
                    fit: BoxFit.cover,
                  )
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: txList.length,
            itemBuilder: (iCtx, index) {
              return Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: CircleAvatar(
                      backgroundColor: _themeConst.primaryColor,
                      radius: 45,
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            "\$${txList[index].price}",
                            style: _themeConst.textTheme.subtitle2.copyWith(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      txList[index].name,
                      style: _themeConst.textTheme.headline6
                          .copyWith(fontSize: 21),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMEd()
                          .format(txList[index].transaction_date),
                      style:
                          _themeConst.textTheme.caption.copyWith(fontSize: 11),
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
                ),
              );
            });
  }
}
