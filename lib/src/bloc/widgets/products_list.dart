import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:work_board/models/utils/constants.dart';
import 'package:work_board/src/bloc/blocs/product_bloc.dart';

import 'package:work_board/widgets/book/book_tile.dart';
import 'package:work_board/widgets/folders/folder_tile.dart';
import 'package:work_board/widgets/prints/print_tile.dart';
import 'package:work_board/widgets/vistCards/visit_card_tile.dart';

class ProductsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _bloc = Provider.of<ProductBloc>(context);
    return StreamBuilder(
      stream: _bloc.currentProducts,
      builder: (context, AsyncSnapshot<CurrentTypeProducts> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              switch (snapshot.data.productType) {
                case ProductType.print:
                  return PrintTile(
                    printModel: snapshot.data.products[index],
                  );
                  break;
                case ProductType.visit_card:
                  return VisitCardTile(
                    visitCardModel: snapshot.data.products[index],
                  );
                  break;
                case ProductType.folder:
                  return FolderTile(
                    folderModel: snapshot.data.products[index],
                  );
                  break;
                case ProductType.book:
                  return BookTile(
                    bookModel: snapshot.data.products[index],
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
            itemCount: snapshot.data.products.length,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
