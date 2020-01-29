import 'package:flutter/material.dart';

import '../constants.dart';

class PrintTileComponentLine extends StatelessWidget {
  final List<String> infos;
  final String description;
  final Color color;
  final bool canBeEdited;
  final bool showChecked;

  PrintTileComponentLine(
      {@required this.infos,
      this.color,
      @required this.canBeEdited,
      this.description,
      @required this.showChecked});

  @override
  Widget build(BuildContext context) {
    List<Widget> rowWidgets = [];
    for (String info in infos) {
      rowWidgets.add(Text(
        info,
        style: TextStyle(
          color: Colors.black87,
          fontWeight: color != null ? FontWeight.bold : FontWeight.normal,
        ),
      ));
    }
    if (showChecked) {
      rowWidgets.add(
        Icon(
          Icons.check,
          color: Colors.green,
        ),
      );
    }
    if (canBeEdited) {
      rowWidgets.add(
        Icon(Icons.arrow_drop_down),
      );
    }

    List<Widget> columnWidgets = [];
    columnWidgets.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: rowWidgets,
      ),
    );
    if (description != null) {
      columnWidgets.add(
        Text(
          description,
          style: TextStyle(
            color: Colors.black54,
//            fontSize: 10,
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(8.0),
      decoration:
          decorationBox.copyWith(color: color != null ? kColor3 : kColor1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columnWidgets,
      ),
    );
  }
}

class PrintTileComponentLine1 extends StatelessWidget {
  final List<String> infos;
  final ColorType colorType;

  PrintTileComponentLine1({
    @required this.infos,
    @required this.colorType,
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

    switch (colorType) {
      case ColorType.OneFaceColor:
        {
          rowWidgets.add(Container(
            width: 30.0,
            height: 30.0,
            color: Colors.red,
          ));
          rowWidgets.add(
            Image(
              image: AssetImage('images/pag1.png'),
            ),
          );
        }
        break;
      case ColorType.OneFaceBlackWhite:
        {
          rowWidgets.add(Container(
            width: 30.0,
            height: 30.0,
            color: Colors.black,
          ));
          rowWidgets.add(
            Image(
              image: AssetImage('images/pag1.png'),
            ),
          );
        }
        break;
      case ColorType.TwoFacesBlackWhite:
        {
          rowWidgets.add(Container(
            width: 30.0,
            height: 30.0,
            color: Colors.black,
          ));
          rowWidgets.add(Container(
            width: 30.0,
            height: 30.0,
            color: Colors.black,
          ));
          rowWidgets.add(
            Image(
              image: AssetImage('images/pag2.png'),
            ),
          );
        }
        break;
      case ColorType.TwoFacesColor:
        {
          rowWidgets.add(Container(
            width: 30.0,
            height: 30.0,
            color: Colors.red,
          ));
          rowWidgets.add(Container(
            width: 30.0,
            height: 30.0,
            color: Colors.red,
          ));
          rowWidgets.add(
            Image(
              image: AssetImage('images/pag2.png'),
            ),
          );
        }
        break;
      case ColorType.OneFaceBlackWhiteOneFaceColor:
        {
          rowWidgets.add(Container(
            width: 30.0,
            height: 30.0,
            color: Colors.red,
          ));
          rowWidgets.add(Container(
            width: 30.0,
            height: 30.0,
            color: Colors.black,
          ));
          rowWidgets.add(
            Image(
              image: AssetImage('images/pag2.png'),
            ),
          );
        }
        break;
    }

    rowWidgets.add(
      Icon(
        Icons.arrow_drop_down,
      ),
    );

    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: rowWidgets,
      ),
    );
  }
}
