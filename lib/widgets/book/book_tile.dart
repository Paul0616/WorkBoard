import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/models/book/book_model.dart';
import 'package:work_board/models/product_data.dart';
import 'package:work_board/models/utils/constants.dart';
import 'package:work_board/models/utils/print_calculator.dart';
import '../product_tile_component_line.dart';
import '../product_tile_component_line_book.dart';

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
              //62 buc (8x7)+(6x1)',
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
        ],

      ),
    );
  }


}


