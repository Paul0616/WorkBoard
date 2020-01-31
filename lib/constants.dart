import 'package:flutter/material.dart';
import 'package:work_board/screens/update_list_screen.dart';
import 'package:work_board/screens/update_single_value_screen.dart';

import 'models/paper_dimension.dart';
import 'models/print_model.dart';

const kColor1 = Colors.white;
const kColor2 = Colors.red;
const kColor3 = Colors.orangeAccent;

const kNomenclatureHeight = 250.0;

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
  OneFaceBlackWhiteOneFaceColorWithFirstBlack,
  OneFaceBlackWhiteOneFaceColorWithFirstColor,
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
  paperFormatCode,
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

String rowToBeModified(String info) {
  for (String value in kPrintModelRowsLabels.values) {
    if (info.contains(value)) {
      return kPrintModelRowsLabels.keys.firstWhere(
          (k) => kPrintModelRowsLabels[k] == value,
          orElse: () => null);
    }
  }
  return null;
}

Widget returnEditWidget(String key, PrintModel printModel) {
  switch (key) {
    case 'Hartie':
      {
        List<String> nomenclature = [];
        kPaperType.forEach((k, v) {
          nomenclature.add(v);
        });
        return UpdateListScreen(
          updateText: 'Tip hârtie',
          nomenclatureValues: nomenclature,
          printModel: printModel,
          code: NomenclatureCode.paperTypeCode,
        );
      }
      break;
    case 'Tiraj':
      {
        return UpdateSingleValueScreen(
          updateText: 'Tiraj',
          printModel: printModel,
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
          updateText: 'Format hârtie',
          nomenclatureValues: nomenclature,
          printModel: printModel,
          code: NomenclatureCode.paperFormatCode,
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
