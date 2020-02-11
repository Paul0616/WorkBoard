import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:work_board/models/book/book_model.dart';

import 'package:work_board/models/utils/constants.dart';

import '../product_tile_component_line.dart';
import '../product_tile_component_line_book.dart';
import '../product_tile_component_line_book_binding.dart';

class BookTile extends StatelessWidget {
  final BookModel bookModel;

  BookTile({this.bookModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: <Widget>[
          ProductTileComponentLine(
            infos: [
              'Tiraj ${bookModel.quantity.toStringAsFixed(0)} buc',
              '${bookModel.value.toStringAsFixed(2)} lei'
            ],
            color: kColorAccent,
            canBeEdited: true,
            canBeDeleted: true,
            model: bookModel,
          ),
          ProductTileComponentLine(
            infos: [
              'Format carte ÎNCHISĂ: ${EnumToString.parse(bookModel.paperFormat.format)}',
            ],
            description:
                'L(mm): ${bookModel.paperFormat.widthL}  H(mm): ${bookModel.paperFormat.lengthH}',
            descriptionCanBeEdited:
                bookModel.paperFormat.format == PaperFormatEnum.LxH,
            canBeEdited: true,
            canBeDeleted: false,
            model: bookModel,
          ),
          BookTileComponentLineBinding(
            infos: ['Mod legare:'],
            bookModel: bookModel,
          ),
          ProductTileComponentLine(
            infos: [
              'INTERIOR:',
            ],
            firstInfoIsBold: true,
            canBeEdited: false,
            canBeDeleted: false,
            model: bookModel,
          ),
          ProductTileComponentLine(
            infos: [
              'Pagini interior (multiplu de 4):',
              '${bookModel.insidePageCountMultiple4} pag',
            ],
            canBeEdited: true,
            canBeDeleted: false,
            model: bookModel,
          ),
          ProductTileComponentLine(
            infos: [
              '${kPrintModelRowsLabels['A3']} ${bookModel.fitsOnA3} buc/A3',
              '${bookModel.interiorPrints} printuri',
            ],
            canBeEdited: false,
            canBeDeleted: false,
            description: '${bookModel.fitsDescription}',
            descriptionCanBeEdited: false,
            model: bookModel,
          ),
          PrintTileComponentLineRadio(
            infos: [
              'Culoare Interior: ',
            ],
            bookModel: bookModel,
            radioType: 'insideColor',
          ),
          ProductTileComponentLine(
            infos: [
              '${kPrintModelRowsLabels['Costuri']}',
              'Color: ${bookModel.colorTypeBookInside == ColorTypeBookInside.Color ? 1 : 0} lei',
              'x ${bookModel.colorTypeBookInside == ColorTypeBookInside.Color ? bookModel.interiorPrints : 0} A4',
              '= ${(bookModel.interiorPrints * 1).toStringAsFixed(2)} lei',
            ],
            canBeEdited: false,
            canBeDeleted: false,
            model: bookModel,
          ),
        ],
      ),
    );
  }
}
