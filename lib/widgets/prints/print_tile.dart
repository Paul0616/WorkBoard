import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:work_board/constants.dart';
import 'package:work_board/models/product_data.dart';
import 'package:work_board/models/prints/print_model.dart';

import 'package:work_board/widgets/prints/print_tile_component_line.dart';

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
              Provider.of<ProductData>(context, listen: false)
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
              '${kPrintModelRowsLabels['A3']} ${printModel.getA3FitCount()['fitCount']} buc/A3',
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
              'Color: ${printModel.printPriceColored} lei',
              'x ${printModel.printCountColored} A4',
              '= ${(printModel.printPriceColored * printModel.printCountColored).toStringAsFixed(2)} lei',
            ],
            canBeEdited: false,
            canBeDeleted: false,
            printModel: printModel,
          ),
          PrintTileComponentLine(
            infos: [
              '${kPrintModelRowsLabels['Costuri']}',
              'A/N:   ${printModel.printPriceGray} lei',
              'x ${printModel.printCountGray} A4',
              '= ${(printModel.printPriceGray * printModel.printCountGray).toStringAsFixed(2)} lei',
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
