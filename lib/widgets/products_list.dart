import 'package:flutter/material.dart';
import 'package:work_board/models/print_data.dart';
import 'package:work_board/widgets/print_tile.dart';

import '../constants.dart';
import 'big_print_tile.dart';

class ProductsList extends StatelessWidget {
  final productType = ProductType.print;

  @override
  Widget build(BuildContext context) {
    Widget productTile;

    switch (productType) {
      case ProductType.print:
        productTile = PrintTile();
        break;
      case ProductType.big_print:
        productTile = BigPrintTile();
        break;
      default:
        {
          print('Product Type unknown');
        }
        break;
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        //final products = PrintData;
        return productTile;
      },
      itemCount: 3,
    );
  }
}
