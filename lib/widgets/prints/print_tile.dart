import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:work_board/models/utils/constants.dart';
import 'package:work_board/models/product_data.dart';
import 'package:work_board/models/prints/print_model.dart';

import 'package:work_board/widgets/product_tile_component_line.dart';

import '../product_tile_component_line_prints_color.dart';

class PrintTile extends StatelessWidget {
  final PrintModel printModel;

  PrintTile({this.printModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: <Widget>[
          ProductTileComponentLine(
            infos: [
              '${kPrintModelRowsLabels['Hartie']} ${printModel.getPaperTypeName()}',
              '${printModel.value.toStringAsFixed(2)} lei'
            ],
            color: kColorAccent,
            canBeEdited: true,
            canBeDeleted: true,
            model: printModel,
          ),
          ProductTileComponentLine(
            infos: [
              '${kPrintModelRowsLabels['Tiraj']} ${printModel.quantity.toStringAsFixed(0)} buc',
            ],
            canBeEdited: true,
            canBeDeleted: false,
            model: printModel,
          ),
          ProductTileComponentLine(
            infos: [
              '${kPrintModelRowsLabels['Format']} ${EnumToString.parse(printModel.paperFormat.format)}',
            ],
            description:
                'L(mm): ${printModel.paperFormat.widthL}  H(mm): ${printModel.paperFormat.lengthH}',
            descriptionCanBeEdited:
                printModel.paperFormat.format == PaperFormatEnum.LxH,
            canBeEdited: true,
            canBeDeleted: false,
            model: printModel,
          ),
          ProductTileComponentLine(
            infos: [
              '${kPrintModelRowsLabels['Taiere']} ${printModel.cuts}',
            ],
            canBeEdited: false,
            canBeDeleted: false,
            showCheckedFunction: (checkboxState) {
              Provider.of<ProductData>(context, listen: false)
                  .updateCuts(printModel);
            },
            model: printModel,
          ),
          PrintTileComponentLinePrintsColor(
            infos: ['${kPrintModelRowsLabels['Imprimare']}'],
            printModel: printModel,
          ),
          ProductTileComponentLine(
            infos: [
              '${kPrintModelRowsLabels['A3']} ${printModel.fitsOnA3} buc/A3',
              //62 buc (8x7)+(6x1)',
            ],
            canBeEdited: false,
            canBeDeleted: false,
            description: '${printModel.fitsDescription}',
            descriptionCanBeEdited: false,
            model: printModel,
          ),
          ProductTileComponentLine(
            infos: [
              '${kPrintModelRowsLabels['Costuri']}',
              'Color: ${printModel.printPriceColored} lei',
              'x ${printModel.printCountColored} A4',
              '= ${(printModel.printPriceColored * printModel.printCountColored).toStringAsFixed(2)} lei',
            ],
            canBeEdited: false,
            canBeDeleted: false,
            model: printModel,
          ),
          ProductTileComponentLine(
            infos: [
              '${kPrintModelRowsLabels['Costuri']}',
              'A/N:   ${printModel.printPriceGray} lei',
              'x ${printModel.printCountGray} A4',
              '= ${(printModel.printPriceGray * printModel.printCountGray).toStringAsFixed(2)} lei',
            ],
            canBeEdited: false,
            canBeDeleted: false,
            model: printModel,
          ),
        ],
      ),
    );
  }
}
