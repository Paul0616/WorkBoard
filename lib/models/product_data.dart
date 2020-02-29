import 'package:flutter/material.dart';
import 'package:work_board/models/book/book_model.dart';
import 'package:work_board/models/folders/folder_model.dart';
import 'package:work_board/models/utils/constants.dart';
import 'package:work_board/models/visitCard/visit_card_model.dart';
import 'package:work_board/models/paper_dimension.dart';
import 'package:work_board/models/prints/print_model.dart';

class ProductData with ChangeNotifier {
  //ProductType productType = ProductType.print;

  List<dynamic> products = [
//    PrintModel(
//      paperType: PaperType.paper80,
//      paperFormat: kDefaultFormats[0],
//      colorType: ColorType.OneFaceColor,
//      addCut: false,
//    ),
//    VisitCardModel(
//      isSpecialPaper: false,
//      bothSidePrinted: false,
//      isPlasticized: false,
//    ),
//    FolderModel(
//      isPlasticized: true,
//      bothSidePrinted: false,
//      doubleEdge: false,
//      havePatchPocket: true,
//    ),

    BookModel(
      paperFormat: kDefaultFormats[0],
      colorTypeBookCovers: [
        ColorTypeBookCovers.TwoFacesColor,
        ColorTypeBookCovers.TwoFacesColor,
      ],
    ),
  ];

  ProductType currentType = ProductType.print;

  dynamic get currentProducts {
    return products.where((product) => product.type == currentType).toList();
  }

  int get productCount {
    return currentProducts.length;
    //return prints.length;
  }

  double get allCurrentTypeValue {
    double sum = 0;

    for (dynamic product in currentProducts) {
      sum += product.value;
    }
    return sum;
  }

  bool productHaveValue(String title) {
    double sum = 0;
    ProductType type;
    kProductTypes.forEach((k, v) {
      if (v == title) type = k;
    });
    List<dynamic> prod =
        products.where((product) => product.type == type).toList();
    for (dynamic product in prod) {
      sum += product.value;
    }
    return sum != 0;
  }

  double get allValue {
    double sum = 0;

    for (dynamic product in products) {
      sum += product.value;
    }
    return sum;
  }

  void changeCurrentProduct(String productType) {
    kProductTypes.forEach((k, v) {
      if (v == productType) currentType = k;
    });
    notifyListeners();
  }

  void updateQuantity(dynamic model, String quantity) {
    try {
      int q = int.parse(quantity);
      model.quantity = q;
      model.refreshPrices();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void setShowAlert(dynamic model, bool value) {
    model.showAlert = value;
    notifyListeners();
  }

  void updatePagInterior(dynamic model, String pagInterior) {
    try {
      int p = int.parse(pagInterior);
      if (!model.showAlert) {
        model.insidePageCountMultiple4 = p;
      }
      model.refreshPrices();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void deletePrintModel(dynamic model) {
    products.remove(model);
    notifyListeners();
  }

  void addPrint(ProductType type) {
    switch (type) {
      case ProductType.book:
        products.add(BookModel(
          paperFormat: kDefaultFormats[0],
          colorTypeBookCovers: [
            ColorTypeBookCovers.TwoFacesColor,
            ColorTypeBookCovers.TwoFacesColor,
          ],
        ));
        break;
      case ProductType.print:
        products.add(PrintModel(
          paperType: PaperType.paper80,
          paperFormat: kDefaultFormats[0],
          colorType: ColorTypeBothSides.OneFaceColor,
          addCut: false,
        ));
        break;
      case ProductType.visit_card:
        products.add(VisitCardModel(
          isSpecialPaper: false,
          bothSidePrinted: false,
          isPlasticized: false,
        ));
        break;
      case ProductType.folder:
        products.add(FolderModel(
          doubleEdge: false,
          bothSidePrinted: false,
          isPlasticized: true,
          havePatchPocket: true,
        ));
        break;
      case ProductType.poster:
        // TODO: Handle this case.
        break;
      case ProductType.big_print:
        // TODO: Handle this case.
        break;
      case ProductType.wall_sticker:
        // TODO: Handle this case.
        break;
      case ProductType.cut_sheets:
        // TODO: Handle this case.
        break;
      case ProductType.cut_paper_sticker:
        // TODO: Handle this case.
        break;
      case ProductType.engraving:
        // TODO: Handle this case.
        break;
      case ProductType.textile_printing:
        // TODO: Handle this case.
        break;
      case ProductType.finishing:
        // TODO: Handle this case.
        break;
    }

    notifyListeners();
  }

  void updateValueFromNomenclature(
      dynamic model, String type, NomenclatureCode code) {
    if (code == NomenclatureCode.paperTypeCode) {
      kPaperType.forEach((k, v) {
        if (v == type) {
          model.paperType = k;
        }
      });
    }
    if (code == NomenclatureCode.paperTypeInteriorCode) {
      kPaperType.forEach((k, v) {
        if (v == type) {
          model.paperTypeInside = k;
        }
      });
    }

    if (code == NomenclatureCode.paperTypeCoversCode) {
      kPaperType.forEach((k, v) {
        if (v == type) {
          model.paperTypeCovers = k;
        }
      });
    }
    //paperTypeInside
    if (code == NomenclatureCode.paperFormatCode) {
      kPaperFormat.forEach((k, v) {
        if (v == type) {
          for (PaperDimensions dim in kDefaultFormats) {
            if (dim.format == k) {
              model.paperFormat = dim;
            }
          }
        }
      });
    }
    model.refreshPrices();
    notifyListeners();
  }

  void updateCuts(PrintModel printModel) {
    printModel.toggleAddCut();
    printModel.refreshPrices();
    notifyListeners();
  }

  void updateCVProperties(VisitCardModel model, VisitCardsProperties property) {
    switch (property) {
      case VisitCardsProperties.isPlasticized:
        model.togglePlasticized();
        break;
      case VisitCardsProperties.bothSides:
        model.toggleBothSide();
        break;
      case VisitCardsProperties.isSpecialPaper:
        model.toggleSpecialPaper();
        break;
    }

    model.refreshPrices();
    notifyListeners();
  }

  void updateFolderProperties(FolderModel model, FolderProperties property) {
    switch (property) {
      case FolderProperties.isPlasticized:
        model.togglePlasticized();
        break;
      case FolderProperties.bothSides:
        model.toggleBothSide();
        break;
      case FolderProperties.doubleEdge:
        model.toggleDoubleEdge();
        break;
      case FolderProperties.havePatchPocket:
        model.togglePatchPocket();
        break;
    }

    model.refreshPrices();
    notifyListeners();
  }

  void updateColorType(PrintModel printModel, bool firstFace) {
    printModel.toggleFaceColor(firstFace);
    printModel.refreshPrices();
    notifyListeners();
  }

  void updateTwoFaces(PrintModel printModel) {
    printModel.toggleTwoFaces();
    printModel.refreshPrices();
    notifyListeners();
  }

  void updateSpiralBinding(BookModel bookModel) {
    bookModel.toggleSpiralBinding();
    bookModel.refreshPrices();
    notifyListeners();
  }

  void updateStaplingBinding(BookModel bookModel) {
    if (!bookModel.spiralBindingOnly) bookModel.setStaplingBinding();

    bookModel.refreshPrices();
    notifyListeners();
  }

  void updateBondingBinding(BookModel bookModel) {
    if (!bookModel.spiralBindingOnly) bookModel.setBondingBinding();
    bookModel.refreshPrices();
    notifyListeners();
  }

  void updateInteriorColor(BookModel bookModel, int val) {
    kColorTypeBookInside.forEach((key, value) {
      if (key.index == val) bookModel.setColorTypeInterior(key);
    });
    bookModel.refreshPrices();
    notifyListeners();
  }

  void updateDimensions(dynamic model, String l, String h) {
    try {
      double widthL = double.parse(l);
      double lengthH = double.parse(h);
      model.paperFormat.widthL = widthL;
      model.paperFormat.lengthH = lengthH;
      model.refreshPrices();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void nextIcon1(BookModel bookModel) {
    bookModel.nextStateIcon1();
    bookModel.refreshPrices();
    notifyListeners();
  }

  void nextIcon2(BookModel bookModel) {
    bookModel.nextStateIcon2();
    bookModel.refreshPrices();
    notifyListeners();
  }

  void nextIconDouble(BookModel bookModel) {
    bookModel.nextStateIconDouble();
    bookModel.refreshPrices();
    notifyListeners();
  }
}
