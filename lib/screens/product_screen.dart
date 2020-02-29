import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/models/product_data.dart';
import 'package:work_board/screens/update_list_screen.dart';
import 'package:work_board/widgets/products_list.dart';

import '../models/utils/constants.dart';

class ProductScreen extends StatelessWidget {
  // final productType = ProductType.print;


  @override
  Widget build(BuildContext context) {
    var products = Provider.of<ProductData>(context);
    List<String> nomenclature = [];
    kProductTypes.forEach((k, v) {
      nomenclature.add(v);
    });
    return Scaffold(
      backgroundColor: kColorTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kColorAccent,
        child: Icon(Icons.add),
        onPressed: () {
          Provider.of<ProductData>(context, listen: false)
              .addPrint(products.currentType);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 50.0,
                          left: 20.0,
                          right: 20.0,
                          bottom: 30.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                      ),
                                      child: UpdateListScreen(
                                        listTitle: 'Alege produs:',
                                        code: NomenclatureCode.productsCode,
                                        nomenclatureValues: nomenclature,
                                      ),
                                    ),
                                  ),
                                  isScrollControlled: true,
                                );
                              },
                              child: Material(
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
                                        color: kColorTop,
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
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              kProductTypes[products.currentType],
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontFamily: 'Yanone Kaffeesatz',
                                fontSize: 50,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Valoare: ${products.allCurrentTypeValue.toStringAsFixed(2)} lei (${products.productCount} produse)',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: kColorAccent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        bottomLeft: Radius.circular(50.0),
                      ),
                      border: Border.all(
                        width: 3,
                        color: Colors.white54,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Pret Total:',
                          style: TextStyle(
                            color: kColorBottom,
                          ),
                        ),
                        Text(
                          '${products.allValue.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontFamily: 'Yanone Kaffeesatz',
                            fontSize: 30.0,
                          ),
                        ),
                        Text('LEI'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 60.0,
              ),
              decoration: BoxDecoration(
                  color: kColorBottom,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  )),
              child: ProductsList(
                productType: products.currentType,
              ),
            ),
          )
        ],
      ),
    );
  }
}
