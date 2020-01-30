import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import 'package:work_board/constants.dart';
import 'package:work_board/models/print_model.dart';

import 'package:work_board/widgets/print_tile_component_line.dart';

class PrintTile extends StatelessWidget {
  final PrintModel printModel;

  PrintTile({this.printModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: <Widget>[
          PrintTileComponentLine(
            infos: [
              'Tip hârtie: ${printModel.getPaperTypeName()}',
              '${printModel.value.toStringAsFixed(2)} lei'
            ],
            color: kColor3,
            canBeEdited: false,
            canBeDeleted: true,
            showChecked: false,
            printModel: printModel,
          ),
          PrintTileComponentLine(
            infos: [
              'Tiraj: ${printModel.quantity.toStringAsFixed(0)} buc',
            ],
            canBeEdited: true,
            canBeDeleted: false,
            showChecked: false,
            printModel: printModel,
          ),
          PrintTileComponentLine(
            infos: [
              'Format: ${EnumToString.parse(printModel.paperFormat.format)}',
              'L(mm): ${printModel.paperFormat.widthL}',
              'H(mm): ${printModel.paperFormat.lengthH}',
            ],
            canBeEdited: true,
            canBeDeleted: false,
            showChecked: false,
          ),
          PrintTileComponentLine(
            infos: [
              'Adaugă tăieri: ${printModel.getA3FitCount()['cut']}',
            ],
            canBeEdited: true,
            canBeDeleted: false,
            showChecked: true,
          ),
          PrintTileComponentLine1(
            infos: ['Imprimare:'],
            colorType: printModel.colorType,
          ),
          PrintTileComponentLine(
            infos: [
              'Încadrare în A3: ${printModel.getA3FitCount()['fitCount']} buc',
              //62 buc (8x7)+(6x1)',
            ],
            canBeEdited: false,
            canBeDeleted: false,
            showChecked: false,
            description: '${printModel.getA3FitCount()['description']}',
          ),
          PrintTileComponentLine(
            infos: [
              'Costuri/A4:',
              'Color: 1.54 lei',
              'x 3 A4',
              '= 4.62 lei',
            ],
            canBeEdited: false,
            canBeDeleted: false,
            showChecked: false,
          ),
          PrintTileComponentLine(
            infos: [
              'Costuri/A4:',
              'A/N:   1.54 lei',
              'x 3 A4',
              '= 4.62 lei',
            ],
            canBeEdited: false,
            canBeDeleted: false,
            showChecked: false,
          ),
        ],
      ),
    );
  }
}
