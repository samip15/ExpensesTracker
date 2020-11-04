import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransection extends StatefulWidget {
  final Function addTransaction;
  AddTransection({@required this.addTransaction});
  @override
  _AddTransectionState createState() => _AddTransectionState();
}

class _AddTransectionState extends State<AddTransection> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  DateTime _selectedDateTime;
  void addTransaction() {
    final String itemName = _nameController.value.text;
    final double itemPrice = double.parse(_priceController.value.text);
    if (itemName.isEmpty ||
        _priceController.value.text.isEmpty ||
        _selectedDateTime == null) {
      return;
    } else if (itemPrice.isNegative) {
      return;
    } else {
      widget.addTransaction(itemName, itemPrice, _selectedDateTime);
    }
    Navigator.pop(context);
  }

  void pickDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickDate) {
      setState(() {
        _selectedDateTime = pickDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _themeConst = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.shopping_bag),
              labelText: "Item Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            keyboardType: TextInputType.text,
            controller: _nameController,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.monetization_on),
              labelText: "Item Price",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            keyboardType: TextInputType.number,
            controller: _priceController,
            textInputAction: TextInputAction.done,
            onSubmitted: (value) => addTransaction(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedDateTime == null
                    ? "No Date Entered"
                    : "Picked Date: ${DateFormat.yMd().format(_selectedDateTime)}",
                style: TextStyle(fontSize: 10),
              ),
              FlatButton(
                onPressed: pickDate,
                padding: EdgeInsets.all(0),
                child: Text(
                  "Choose a Date",
                  style: _themeConst.textTheme.headline6
                      .copyWith(fontSize: 15, color: _themeConst.primaryColor),
                ),
              ),
            ],
          ),
          RaisedButton(
            onPressed: addTransaction,
            child: Text("Add Transaction"),
            color: _themeConst.accentColor,
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}
