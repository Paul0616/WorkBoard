import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/models/book/book_model.dart';
import 'package:work_board/models/product_data.dart';
import 'package:work_board/models/utils/constants.dart';

class BookTileComponentLineCovers extends StatelessWidget {
  final List<String> infos;
  final BookModel bookModel;

  BookTileComponentLineCovers({
    @required this.infos,
    @required this.bookModel,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> rowWidgets = [];
    for (String info in infos) {
      if (info == infos[0])
        rowWidgets.add(Text(
          info,
          style: TextStyle(
            color: Colors.black54,
          ),
        ));
      else
        rowWidgets.add(Text(
          info,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 10,
          ),
        ));
    }
    List<Widget> rowIconsWidgets = [];

    if (bookModel.binding == Binding.SpiralBindingLandscape ||
        bookModel.binding == Binding.SpiralBindingPortrait) {
      rowIconsWidgets.add(GestureDetector(
        onTap: () {
//            Provider.of<ProductData>(context, listen: false)
//                .updateSpiralBinding(bookModel);
        },
        child: Image(
          height: 70,
          image: AssetImage('images/pagCC.png'),
        ),
      ));

      rowIconsWidgets.add(GestureDetector(
        onTap: () {
//            Provider.of<ProductData>(context, listen: false)
//                .updateSpiralBinding(bookModel);
        },
        child: Image(
          height: 70,
          image: AssetImage('images/pagCC2.png'),
        ),
      ));
    }

    if (bookModel.binding == Binding.Stapling ||
        bookModel.binding == Binding.Bonding) {
      rowIconsWidgets.add(GestureDetector(
        onTap: () {
//        Provider.of<ProductData>(context, listen: false)
//            .updateStaplingBinding(bookModel);
        },
        child: Image(
          height: 70,
          image: AssetImage('images/pagdublaCC.png'),
        ),
      ));
    }

    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: rowWidgets,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: rowIconsWidgets,
            ),
          ),
        ],
      ),
    );
  }
}
