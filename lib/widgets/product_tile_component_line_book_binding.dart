import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/models/book/book_model.dart';
import 'package:work_board/models/product_data.dart';
import 'package:work_board/models/utils/constants.dart';

class BookTileComponentLineBinding extends StatelessWidget {
  final List<String> infos;
  final BookModel bookModel;

  BookTileComponentLineBinding({
    @required this.infos,
    @required this.bookModel,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> rowWidgets = [];
    for (String info in infos) {
      rowWidgets.add(Text(
        info,
        style: TextStyle(
          color: Colors.black54,
        ),
      ));
    }
    List<Widget> rowIconsWidgets = [];
    rowIconsWidgets.add(Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Provider.of<ProductData>(context, listen: false)
                .updateSpiralBinding(bookModel);
          },
          child: Image(
            height: 70,
            color: bookModel.binding == Binding.Stapling ||
                    bookModel.binding == Binding.Bonding
                ? Color.fromRGBO(255, 255, 255, 0.3)
                : null,
            colorBlendMode: BlendMode.modulate,
            image: AssetImage(bookModel.binding == Binding.SpiralBindingPortrait
                ? 'images/arc_lung1.png'
                : 'images/arc_scurt1.png'),
          ),
        ),
        Text(
          'Cu spira',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 10,
          ),
        ),
      ],
    ));
    rowIconsWidgets.add(Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Provider.of<ProductData>(context, listen: false)
                .updateStaplingBinding(bookModel);
          },
          child: Image(
            height: 50,
            color: bookModel.binding == Binding.Stapling
                ? null
                : Color.fromRGBO(255, 255, 255, 0.3),
            colorBlendMode: BlendMode.modulate,
            image: AssetImage('images/capsare1.png'),
          ),
        ),
        Text(
          'Capsare',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 10,
          ),
        ),
      ],
    ));
    rowIconsWidgets.add(Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Provider.of<ProductData>(context, listen: false)
                .updateBondingBinding(bookModel);
          },
          child: Image(
            height: 50,
            color: bookModel.binding == Binding.Bonding
                ? null
                : Color.fromRGBO(255, 255, 255, 0.3),
            colorBlendMode: BlendMode.modulate,
            image: AssetImage('images/brosare1.png'),
          ),
        ),
        Text(
          'Brosare',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 10,
          ),
        ),
      ],
    ));
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: rowIconsWidgets,
            ),
          ),
        ],
      ),
    );
  }
}
