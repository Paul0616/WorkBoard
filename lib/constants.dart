import 'package:flutter/material.dart';


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


enum PaperFormatEnum {
  A3,
  A4,
  A5,
  A6,
  Banner,
  LxH,
}

const Map<String, String> kPrintModelRowsLabels = {
  'Hartie': 'Tip hârtie:',
  'Tiraj': 'Tiraj:',
  'Format': 'Format:',
  'Taiere': 'Adaugă tăieri:',
  'Imprimare': 'Imprimare:',
  'A3': 'Încadrare în A3:',
  'Costuri': 'Costuri/A4:',
};
