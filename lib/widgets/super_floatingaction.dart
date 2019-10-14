import 'package:flutter/material.dart';

class SuperFloatingAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          child: Icon(Icons.account_balance),
          backgroundColor: Colors.indigo,
          onPressed: () {},
        ),
        SizedBox(
          height: 10.0,
        ),
        FloatingActionButton(
          child: Icon(Icons.account_balance),
          backgroundColor: Colors.red,
          onPressed: () {},
        ),
      ],
    );
  }
}
