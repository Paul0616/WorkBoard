import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/models/product_data.dart';
import 'package:work_board/widgets/book/book_tile.dart';
import 'package:work_board/widgets/folders/folder_tile.dart';
import 'package:work_board/widgets/prints/print_tile.dart';
import 'package:work_board/widgets/vistCards/visit_card_tile.dart';

import '../models/utils/constants.dart';

class ProductsList extends StatelessWidget {
  final productType;
  ProductsList({this.productType});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        var model = Provider.of<ProductData>(context).currentProducts[index];
        switch (productType) {
          case ProductType.print:
            return PrintTile(
              printModel: model,
            );
            break;
          case ProductType.visit_card:
            return VisitCardTile(
              visitCardModel: model,
            );
            break;
          case ProductType.folder:
            return FolderTile(
              folderModel: model,
            );
            break;
          case ProductType.book:
            return BookTile(
              bookModel: model,
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
