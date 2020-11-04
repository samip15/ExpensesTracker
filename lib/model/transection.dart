import 'package:flutter/foundation.dart';

class Transaction {
  String name;
  double price;
  DateTime transaction_date;
  String id;

  Transaction(
      {@required this.name,
      @required this.id,
      @required this.price,
      @required this.transaction_date});
}
