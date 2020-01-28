import 'package:flutter/material.dart';
import 'package:work_board/widgets/products_list.dart';

import '../constants.dart';

class ProductScreen extends StatelessWidget {
  final productType = ProductType.print;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColor2,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 50.0,
              left: 20.0,
              right: 20.0,
              bottom: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Material(
                  elevation: 6,
                  shape: CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.dashboard,
                          color: kColor1,
                          size: 40.0,
                        ),
                        Text(
                          'Product',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Printuri Mari',
                  style: TextStyle(
                    fontFamily: 'Yanone Kaffeesatz',
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Valoare: 15.00',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                  color: kColor1,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  )),
              child: ProductsList(),
            ),
          )
        ],
      ),
    );
  }
}
