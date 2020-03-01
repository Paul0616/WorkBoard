import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/models/product_data.dart';
import 'package:work_board/models/utils/constants.dart';
import 'package:work_board/src/bloc/blocs/product_bloc.dart';

import 'package:work_board/widgets/book/book_tile.dart';
import 'package:work_board/widgets/folders/folder_tile.dart';
import 'package:work_board/widgets/prints/print_tile.dart';
import 'package:work_board/widgets/vistCards/visit_card_tile.dart';

class ProductsList extends StatelessWidget {
  final productType;

  ProductsList({this.productType});

  @override
  Widget build(BuildContext context) {
    var _bloc = Provider.of<ProductBloc>(context);
    print(productType);
    return StreamBuilder(
      stream: _bloc.products,
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          print('hasdata ${snapshot.data}');
          return ListView.builder(
            itemBuilder: (context, index) {
              switch (productType) {
                case ProductType.print:
                  return PrintTile(
                    printModel: snapshot.data[index],
                  );
                  break;
                case ProductType.visit_card:
                  return VisitCardTile(
                    visitCardModel: snapshot.data[index],
                  );
                  break;
                case ProductType.folder:
                  return FolderTile(
                    folderModel: snapshot.data[index],
                  );
                  break;
                case ProductType.book:
                  return BookTile(
                    bookModel: snapshot.data[index],
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
            itemCount: snapshot.data.length,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
