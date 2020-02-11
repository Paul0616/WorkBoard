import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:work_board/models/book/book_model.dart';
import 'package:work_board/models/utils/constants.dart';
import 'package:work_board/widgets/product_tile_component_line_book_covers.dart';
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
            infos: [
              'Mod legare:',
              '(pentru A3 si Banner doar legare cu spira)',
            ],
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
              '${bookModel.colorTypeBookInside == ColorTypeBookInside.HalfColorHalfBlackWhite ? bookModel.interiorPrints * 2 : bookModel.interiorPrints} printuri',
            ],
            canBeEdited: false,
            canBeDeleted: false,
            description: '${bookModel.fitsDescription}',
            descriptionCanBeEdited: false,
            model: bookModel,
          ),
          ProductTileComponentLine(
            infos: [
              '${kBookModelRowsLabels['HartieInt']} ${bookModel.getPaperTypeName(bookModel.paperTypeInside)}',
            ],
            canBeEdited: true,
            canBeDeleted: false,
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
              '${kBookModelRowsLabels['Costuri']}',
              'Color: ${bookModel.colorTypeBookInside != ColorTypeBookInside.BlackWhite ? bookModel.printPriceInteriorColored.toStringAsFixed(2) : 0} lei',
              'x ${bookModel.colorTypeBookInside != ColorTypeBookInside.BlackWhite ? bookModel.interiorPrints : 0} A4',
              '= ${(bookModel.colorTypeBookInside != ColorTypeBookInside.BlackWhite ? bookModel.interiorPrints * bookModel.printPriceInteriorColored : 0).toStringAsFixed(2)} lei',
            ],
            canBeEdited: false,
            canBeDeleted: false,
            model: bookModel,
          ),
          ProductTileComponentLine(
            infos: [
              '${kBookModelRowsLabels['Costuri']}',
              'A/N: ${bookModel.colorTypeBookInside != ColorTypeBookInside.Color ? bookModel.printPriceInteriorGray.toStringAsFixed(2) : 0} lei',
              'x ${bookModel.colorTypeBookInside != ColorTypeBookInside.Color ? bookModel.interiorPrints : 0} A4',
              '= ${(bookModel.colorTypeBookInside != ColorTypeBookInside.Color ? bookModel.interiorPrints * bookModel.printPriceInteriorGray : 0).toStringAsFixed(2)} lei',
            ],
            canBeEdited: false,
            canBeDeleted: false,
            model: bookModel,
          ),
          ProductTileComponentLine(
            infos: [
              'COPERȚI:',
            ],
            firstInfoIsBold: true,
            canBeEdited: false,
            canBeDeleted: false,
            model: bookModel,
          ),
          ProductTileComponentLine(
            infos: [
              '${kBookModelRowsLabels['HartieCop']} ${bookModel.getPaperTypeName(bookModel.paperTypeCovers)}',
            ],
            canBeEdited: true,
            canBeDeleted: false,
            model: bookModel,
          ),
          BookTileComponentLineCovers(
            infos: [
              'Culoare coperți:',
            ],
            bookModel: bookModel,
          ),
        ],
      ),
    );
  }
}
