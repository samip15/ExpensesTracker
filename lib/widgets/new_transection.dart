import 'package:flutter/material.dart';

class AddTransection extends StatefulWidget {
  @override
  _AddTransectionState createState() => _AddTransectionState();
}

class _AddTransectionState extends State<AddTransection> {
  @override
  Widget build(BuildContext context) {
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "No Date Entered",
                style: TextStyle(fontSize: 18),
              ),
              FlatButton(
                onPressed: () {},
                padding: EdgeInsets.all(0),
                child: Text(
                  "Choose a Date",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          RaisedButton(
            onPressed: () {},
            child: Text("Add Transaction"),
            color: Colors.green,
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}
