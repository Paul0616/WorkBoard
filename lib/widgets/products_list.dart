import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/models/product_data.dart';
import 'package:work_board/widgets/prints/print_tile.dart';
import 'package:work_board/widgets/vistCards/visit_card_tile.dart';

import '../constants.dart';

class ProductsList extends StatelessWidget {
  final productType;
  ProductsList({this.productType});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        switch (productType) {
          case ProductType.print:
            return PrintTile(
              printModel:
                  Provider.of<ProductData>(context).currentProducts[index],
            );
            break;
          case ProductType.visit_card:
            return VisitCardTile(
              visitCardModel:
                  Provider.of<ProductData>(context).currentProducts[index],
            );
            break;
          default:
            {
              print('Product Type unknown');
              return null;
            }
            break;
        }
      },
      itemCount: Provider.of<ProductData>(context).productCount,
    );
  }
}
