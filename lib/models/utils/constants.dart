import 'package:flutter/material.dart';

import 'package:work_board/screens/update_list_screen.dart';
import 'package:work_board/screens/update_single_value_screen.dart';

import '../paper_dimension.dart';

List<double> preturiColor80 = [1.4, 1.30, 1.20, 1.1, 0.95];
List<double> preturiColor115 = [1.6, 1.5, 1.4, 1.3, 1.05];
List<double> preturiColor150 = [1.7, 1.6, 1.5, 1.4, 1.2];
List<double> preturiColor250 = [1.8, 1.7, 1.6, 1.5, 1.25];
List<double> preturiColorac = [2.1, 2.0, 1.9, 1.7, 1.5];
List<double> preturiColorcs = [2.2, 2.1, 2.0, 1.9, 1.75];

List<double> preturiAN80 = [0.35, 0.3, 0.25, 0.23, 0.18];
List<double> preturiAN115 = [0.55, 0.5, 0.45, 0.4, 0.33];
List<double> preturiAN150 = [0.65, 0.6, 0.55, 0.45, 0.38];
List<double> preturiAN250 = [0.75, 0.7, 0.6, 0.5, 0.43];
List<double> preturiANac = [0.85, 0.75, 0.65, 0.55, 0.48];
List<double> preturiANcs = [1.15, 1.1, 1.05, 1.05, 1];

const double kCuttingPrice = 0.25;

//pt laminare se adauga 0.05 si pt fata verso se adauga 0.15,
//pt carton special se adauga 0.1
const double kVisitCardBasePrice = 0.4;

const double kPatchPocketPrice = 2.0;
const double kFoldingPrice = 0.25;
const double kPlasticizingA3Price = 1.0;

const kColorBottom = Colors.white;
const kColorTop = Colors.red;
const kColorAccent = Colors.orangeAccent;

const kNomenclatureHeight = 250.0;

const Map<PaperType, double> kUnprinted = {
  PaperType.paper250: 0.5,
  PaperType.paper150: 0.3,
  PaperType.paper115: 0.25,
  PaperType.paper80: 0.1,
  PaperType.paperSpecial: 1,
  PaperType.paperSticker: 0,
};

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

const Map<ProductType, String> kProductTypes = {
  ProductType.book: 'Carte Broșura Pliant',
  ProductType.print: 'Printuri',
  ProductType.visit_card: 'Cărți Vizită',
  ProductType.folder: 'Mape',
  ProductType.poster: 'Afise',
  ProductType.big_print: 'Printuri mari',
  ProductType.wall_sticker: 'Stickere perete',
  ProductType.cut_sheets: 'Cutteari folie',
  ProductType.cut_paper_sticker: 'Cutterari autocolant hartie',
  ProductType.engraving: 'Gravari',
  ProductType.textile_printing: 'Imprimari textile',
  ProductType.finishing: 'Finisari',
};

enum ColorTypeBothSides {
  OneFaceColor,
  OneFaceBlackWhite,
  TwoFacesColor,
  TwoFacesBlackWhite,
  OneFaceBlackWhiteOneFaceColorWithFirstBlack,
  OneFaceBlackWhiteOneFaceColorWithFirstColor,
}
enum ColorTypeBookCovers {
  Unprinted,
  OneFaceColor,
  OneFaceBlackWhite,
  TwoFacesColor,
  TwoFacesBlackWhite,
  OneFaceColorOneBlackWhiteColor,
}

const List<String> kCovertColorIcons1 = [
  'images/pagN.png',
  'images/pagCN.png',
  'images/pagAN.png',
  'images/pagCC.png',
  'images/pagAA.png',
  'images/pagCA.png'
];

const List<String> kCovertColorIcons2 = [
  'images/pagN.png',
  'images/pagCN2.png',
  'images/pagAN2.png',
  'images/pagCC2.png',
  'images/pagAA2.png',
  'images/pagCA2.png'
];

const List<String> kCovertColorDoubleIcons = [
  'images/pagdublaN.png',
  'images/pagdublaCN.png',
  'images/pagdublaAN.png',
  'images/pagdublaCC.png',
  'images/pagdublaAA.png',
  'images/pagdublaCA.png'
];

enum ColorTypeBookInside {
  Color,
  BlackWhite,
  HalfColorHalfBlackWhite,
}

enum ColorTypeOneSide {
  Color,
  BlackWhite,
}

const Map<ColorTypeBookInside, String> kColorTypeBookInside = {
  ColorTypeBookInside.Color: 'Color',
  ColorTypeBookInside.BlackWhite: 'Alb Negru',
  ColorTypeBookInside.HalfColorHalfBlackWhite: '½ Color + ½ Alb Negru',
};

enum Binding {
  SpiralBindingPortrait,
  SpiralBindingLandscape,
  Stapling,
  Bonding,
}
enum CoversPlasticizing {
  None,
  OneFace,
  BothFaces,
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

enum VisitCardsProperties {
  isPlasticized,
  bothSides,
  isSpecialPaper,
}

enum FolderProperties {
  isPlasticized,
  bothSides,
  doubleEdge,
  havePatchPocket,
}

const Map<PaperFormatEnum, String> kPaperFormat = {
  PaperFormatEnum.A3: 'A3 (297x420)',
  PaperFormatEnum.A4: 'A4 (210x297)',
  PaperFormatEnum.A5: 'A5 (148x210)',
  PaperFormatEnum.A6: 'A6 (105x148)',
  PaperFormatEnum.Banner: 'Banner (640x220)',
  PaperFormatEnum.LxH: 'LxH (custom)',
};

final List<PaperDimensions> kDefaultFormats = [
  PaperDimensions(
    format: PaperFormatEnum.A3,
    L: 297.0,
    H: 420.0,
  ),
  PaperDimensions(
    format: PaperFormatEnum.A4,
    L: 210.0,
    H: 297.0,
  ),
  PaperDimensions(
    format: PaperFormatEnum.A5,
    L: 148.0,
    H: 210.0,
  ),
  PaperDimensions(
    format: PaperFormatEnum.A6,
    L: 105.0,
    H: 148.0,
  ),
  PaperDimensions(
    format: PaperFormatEnum.Banner,
    L: 640.0,
    H: 220.0,
  ),
  PaperDimensions(
    format: PaperFormatEnum.LxH,
    L: 40.0,
    H: 40.0,
  )
];

enum PaperFormatEnum {
  A3,
  A4,
  A5,
  A6,
  Banner,
  LxH,
}

enum NomenclatureCode {
  paperTypeCode,
  paperTypeInteriorCode,
  paperTypeCoversCode,
  paperFormatCode,
  productsCode,
}

const Map<String, String> kPrintModelRowsLabels = {
  'Hartie': 'Tip hârtie:',
  'Tiraj': 'Tiraj:',
  'Format': 'Format:',
  'Taiere': 'Adaugă tăieri:',
  'Imprimare': 'Imprimare:',
  'A3': 'Încadrare:',
  'Costuri': 'Cost/A4:',
};

const Map<String, String> kBookModelRowsLabels = {
  'HartieInt': 'Interior hârtie:',
  'HartieCop': 'Coperți hârtie:',
  'Tiraj': 'Tiraj',
  'Format': 'Format',
  'PagInterior': 'Pagini interior',
//  'Taiere': 'Adaugă tăieri:',
//  'Imprimare': 'Imprimare:',
//  'A3': 'Încadrare:',
  'Costuri': 'Cost/A4:',
};

ProductType stringToProductType(String title) {
  ProductType type;
  kProductTypes.forEach((k, v) {
    if (v == title) type = k;
  });
  return type;
}

String rowToBeModified(String info, ProductType product) {
  if (product == ProductType.print) {
    for (String value in kPrintModelRowsLabels.values) {
      if (info.contains(value)) {
        return kPrintModelRowsLabels.keys.firstWhere(
            (k) => kPrintModelRowsLabels[k] == value,
            orElse: () => null);
      }
    }
  }
  if (product == ProductType.book) {
    for (String value in kBookModelRowsLabels.values) {
      if (info.contains(value)) {
        return kBookModelRowsLabels.keys.firstWhere(
            (k) => kBookModelRowsLabels[k] == value,
            orElse: () => null);
      }
    }
  }
  return null;
}

Widget componentToBeEdited(String key, dynamic model) {
  //print(key);
  switch (key) {
    case 'Hartie':
      {
        List<String> nomenclature = [];
        kPaperType.forEach((k, v) {
          nomenclature.add(v);
        });
        return UpdateListScreen(
          listTitle: 'Tip hârtie',
          nomenclatureValues: nomenclature,
          model: model,
          code: NomenclatureCode.paperTypeCode,
        );
      }
      break;
    case 'HartieInt':
      {
        List<String> nomenclature = [];
        kPaperType.forEach((k, v) {
          nomenclature.add(v);
        });
        return UpdateListScreen(
          listTitle: 'Tip hârtie',
          nomenclatureValues: nomenclature,
          model: model,
          code: NomenclatureCode.paperTypeInteriorCode,
        );
      }
      break;
    case 'HartieCop':
      {
        List<String> nomenclature = [];
        kPaperType.forEach((k, v) {
          nomenclature.add(v);
        });
        return UpdateListScreen(
          listTitle: 'Tip hârtie',
          nomenclatureValues: nomenclature,
          model: model,
          code: NomenclatureCode.paperTypeCoversCode,
        );
      }
      break;
    case 'Tiraj':
      {
        return UpdateSingleValueScreen(
          updateText: 'Tiraj',
          model: model,
        );
      }
      break;
    case 'Format':
      {
        List<String> nomenclature = [];
        kPaperFormat.forEach((k, v) {
          nomenclature.add(v);
        });

        return UpdateListScreen(
          listTitle: 'Format hârtie',
          nomenclatureValues: nomenclature,
          model: model,
          code: NomenclatureCode.paperFormatCode,
        );
      }
      break;
    case 'PagInterior':
      {
        return UpdateSingleValueScreen(
          updateText: 'Pagini interior',
          model: model,
        );
      }
      break;
    default:
      {
        return null;
      }
      break;
  }
}
