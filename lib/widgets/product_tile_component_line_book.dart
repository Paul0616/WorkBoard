import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/models/book/book_model.dart';
import 'package:work_board/models/product_data.dart';
import 'package:work_board/models/utils/constants.dart';

class PrintTileComponentLineRadio extends StatelessWidget {
  final List<String> infos;
  final BookModel bookModel;
  final String radioType;

  PrintTileComponentLineRadio({this.infos, this.bookModel, this.radioType});

  @override
  Widget build(BuildContext context) {
    List<Widget> rowWidgetsInfos = [];
    List<Widget> rowWidgetsColors = [];
    for (String info in infos) {
      rowWidgetsInfos.add(Text(
        info,
        style: TextStyle(
          color: Colors.black54,
        ),
      ));
    }

    switch (radioType) {
      case 'insideColor':
        {
          List<Widget> radios = [];
          kColorTypeBookInside.forEach((k, v) {
            radios.add(Column(
              children: <Widget>[
                Radio(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: k.index,
                  groupValue: bookModel.colorTypeBookInside.index,
                  activeColor: kColorTop,
                  onChanged: (val) {
//                    print(bookModel.colorTypeBookInside);
//                    print(val);
                    Provider.of<ProductData>(context, listen: false)
                        .updateInteriorColor(bookModel, val);
                  },
                ),
                Text(
                  v,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 10,
                  ),
                ),
              ],
            ));
          });
          rowWidgetsColors.add(Expanded(
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: radios,
            ),
          ));
        }
        break;
    }
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: decorationBox,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: rowWidgetsInfos,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: rowWidgetsColors,
          ),
        ],
      ),
    );
  }
}
