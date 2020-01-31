import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/models/print_data.dart';
import 'package:work_board/models/print_model.dart';
import 'package:work_board/screens/update_list_screen.dart';
import 'package:work_board/screens/update_single_value_screen.dart';

import '../constants.dart';

class PrintTileComponentLine extends StatelessWidget {
  final List<String> infos;
  final String description;
  final Color color;
  final bool canBeEdited;
  final bool canBeDeleted;
  final Function showCheckedFunction;
  final PrintModel printModel;

  PrintTileComponentLine(
      {@required this.infos,
      this.color,
      @required this.canBeEdited,
      @required this.canBeDeleted,
      this.description,
      this.showCheckedFunction,
      this.printModel});

  String rowToBeModified(String info) {
    for(String value in kPrintModelRowsLabels.values){
      //print(value);
      if (info.contains(value)) {
        return kPrintModelRowsLabels.keys.firstWhere(
                (k) => kPrintModelRowsLabels[k] == value, orElse: () => null);
      }
    }
    return null;
  }

  Widget returnEditWidget(String key){
    switch (key) {
      case 'Hartie':
        {
          List<String> nomenclature = [];
          kPaperType.forEach((k,v){
            nomenclature.add(v);
          });
          return UpdateListScreen(
            updateText: 'Tip hârtie',
            nomenclatureValues: nomenclature,
            printModel: printModel,
          );
        }
        break;
      case 'Tiraj':
        {
          return UpdateSingleValueScreen(
            updateText: 'Tiraj',
            printModel: printModel,
          );
        }
        break;
      case 'Format':
        {
          return null;
        }
        break;
      case 'Taiere':
        {
          return null;
        }
        break;
      case 'Imprimare':
        {
          return null;
        }
        break;
      default:
        {
          return null;
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rowWidgets = [];
    for (String info in infos) {
      rowWidgets.add(Text(
        info,
        style: TextStyle(
          color: Colors.black54,
          fontWeight: color != null ? FontWeight.bold : FontWeight.normal,
        ),
      ));
    }
    if (canBeDeleted) {
      rowWidgets.add(
        GestureDetector(
          onTap: () {
            Provider.of<PrintData>(context, listen: false)
                .deletePrintModel(printModel);
          },
          child: Icon(
            Icons.delete,
            color: Colors.black54,
          ),
        ),
      );
    }
    print('CUT: ${printModel.addCut}');
    if (showCheckedFunction != null) {
      rowWidgets.add(
        Checkbox(
          focusColor: kColor2,
          activeColor: kColor2,
          value: printModel.addCut,
          onChanged: showCheckedFunction,
        ),
      );
    }

    String rowIdentifier = rowToBeModified(infos[0]);
    if (canBeEdited && rowIdentifier != null) {
      rowWidgets.add(
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: returnEditWidget(rowIdentifier),
                ),
              ),
              isScrollControlled: true,
            );
          },
          child: Icon(
            Icons.arrow_drop_down,
          ),
        ),
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
            color: Colors.red,
            fontSize: 10,
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
