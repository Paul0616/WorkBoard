import 'package:flutter/material.dart';
import 'package:work_board/models/paper_dimension.dart';

const kColor1 = Colors.white;
const kColor2 = Colors.red;
const kColor3 = Colors.orangeAccent;

const decorationBox = BoxDecoration(
  border: Border(
    bottom: BorderSide(
      width: 1.0,
      color: Colors.black26,
    ),
  ),
);

enum ProductType {
  book,
  print,
  visit_card,
  folder,
  poster,
  big_print,
  wall_sticker,
  cut_sheets,
  cut_paper_sticker,
  engraving,
  textile_printing,
  finishing,
}

enum ColorType {
  OneFaceColor,
  OneFaceBlackWhite,
  TwoFacesColor,
  TwoFacesBlackWhite,
  OneFaceBlackWhiteOneFaceColor,
}

const Map<PaperType, String> kPaperType = {
  PaperType.paper80: '80g/mp',
  PaperType.paper115: '115g/mp',
  PaperType.paper150: '150g/mp',
  PaperType.paper250: '250g/mp',
  PaperType.paperSticker: 'autocolant',
  PaperType.paperSpecial: 'carton special',
};

enum PaperType {
  paper80,
  paper115,
  paper150,
  paper250,
  paperSticker,
  paperSpecial,
}

//const Map<PaperFormatEnum, PaperDimensions> kPaperFormatWidthL = {
//  PaperFormatEnum.A3: PaperDimensions(L: 297.0, H: 420.0),
//  PaperFormatEnum.A4: 210.0,
//  PaperFormatEnum.A5: 148.0,
//  PaperFormatEnum.A6: 105.0,
//  PaperFormatEnum.Banner: 640.0,
//  PaperFormatEnum.LxH: 40.0,
//};

enum PaperFormatEnum {
  A3,
  A4,
  A5,
  A6,
  Banner,
  LxH,
}
