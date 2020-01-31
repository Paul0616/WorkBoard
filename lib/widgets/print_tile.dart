import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:work_board/constants.dart';
import 'package:work_board/models/print_data.dart';
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
              '${kPrintModelRowsLabels['Hartie']} ${printModel.getPaperTypeName()}',
              '${printModel.value.toStringAsFixed(2)} lei'
            ],
            color: kColor3,
            canBeEdited: true,
            canBeDeleted: true,
            printModel: printModel,
          ),
          PrintTileComponentLine(
            infos: [
              '${kPrintModelRowsLabels['Tiraj']} ${printModel.quantity.toStringAsFixed(0)} buc',
            ],
            canBeEdited: true,
            canBeDeleted: false,
            printModel: printModel,
          ),
          PrintTileComponentLine(
            infos: [
              '${kPrintModelRowsLabels['Format']} ${EnumToString.parse(printModel.paperFormat.format)}',
            ],
            description:
                'L(mm): ${printModel.paperFormat.widthL}  H(mm): ${printModel.paperFormat.lengthH}',
            descriptionCanBeEdited:
                printModel.paperFormat.format == PaperFormatEnum.LxH,
            canBeEdited: true,
            canBeDeleted: false,
            printModel: printModel,
          ),
          PrintTileComponentLine(
            infos: [
              '${kPrintModelRowsLabels['Taiere']} ${printModel.getA3FitCount()['cut']}',
            ],
            canBeEdited: false,
            canBeDeleted: false,
            showCheckedFunction: (checkboxState) {
              Provider.of<PrintData>(context, listen: false)
                  .updateCuts(printModel);
            },
            printModel: printModel,
          ),
          PrintTileComponentLine1(
            infos: ['${kPrintModelRowsLabels['Imprimare']}'],
            printModel: printModel,
          ),
          PrintTileComponentLine(
            infos: [
              '${kPrintModelRowsLabels['A3']} ${printModel.getA3FitCount()['fitCount']} buc',
              //62 buc (8x7)+(6x1)',
            ],
            canBeEdited: false,
            canBeDeleted: false,
            description: '${printModel.getA3FitCount()['description']}',
            descriptionCanBeEdited: false,
            printModel: printModel,
          ),
          PrintTileComponentLine(
            infos: [
              '${kPrintModelRowsLabels['Costuri']}',
              'Color: 1.54 lei',
              'x 3 A4',
              '= 4.62 lei',
            ],
            canBeEdited: false,
            canBeDeleted: false,
            printModel: printModel,
          ),
          PrintTileComponentLine(
            infos: [
              '${kPrintModelRowsLabels['Costuri']}',
              'A/N:   1.54 lei',
              'x 3 A4',
              '= 4.62 lei',
            ],
            canBeEdited: false,
            canBeDeleted: false,
            printModel: printModel,
          ),
        ],
      ),
    );
  }
}
