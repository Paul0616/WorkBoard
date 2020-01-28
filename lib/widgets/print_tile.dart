import 'package:flutter/material.dart';

class PrintTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Format: A5'),
          Text('L(mm): 148'),
          Text('H(mm): 210'),
        ],
      ),
    );
  }
}
