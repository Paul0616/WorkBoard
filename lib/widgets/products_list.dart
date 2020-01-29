import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/models/print_data.dart';
import 'package:work_board/widgets/print_tile.dart';

import '../constants.dart';
import 'big_print_tile.dart';

class ProductsList extends StatelessWidget {
  final productType = ProductType.print;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        switch (productType) {
          case ProductType.print:
            return PrintTile(
              printModel: Provider.of<PrintData>(context).products[index],
            );
            break;
          case ProductType.big_print:
            return BigPrintTile();
            break;
          default:
            {
              print('Product Type unknown');
              return null;
            }
            break;
        }
      },
      itemCount: Provider.of<PrintData>(context).productCount,
    );
  }
}
