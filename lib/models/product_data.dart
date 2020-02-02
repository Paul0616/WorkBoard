import 'package:flutter/material.dart';
import 'package:work_board/constants.dart';
import 'package:work_board/models/visitCard/visit_card_model.dart';
import 'package:work_board/models/paper_dimension.dart';
import 'package:work_board/models/prints/print_model.dart';

class ProductData with ChangeNotifier {
  //ProductType productType = ProductType.print;

  List<dynamic> products = [
    PrintModel(
      paperType: PaperType.paper80,
      paperFormat: kDefaultFormats[0],
      colorType: ColorType.OneFaceColor,
      addCut: false,
    ),
    VisitCardPrintModel(
      isSpecialPaper: false,
      bothSidePrinted: false,
      isPlasticized: false,
      type: ProductType.visit_card,
    )
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

  void changeCurrentProduct(String productType){
    kProductTypes.forEach((k, v) {
      if (v == productType) currentType = k;
    });
    notifyListeners();
  }

  void updateQuantity(PrintModel printModel, String quantity) {
    try {
      int q = int.parse(quantity);
      printModel.quantity = q;
      printModel.refreshPrices();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void deletePrintModel(PrintModel printModel) {
    products.remove(printModel);
    notifyListeners();
  }

  void addPrint() {
    products.add(PrintModel(
      paperType: PaperType.paper80,
      paperFormat: kDefaultFormats[0],
      colorType: ColorType.OneFaceColor,
      addCut: false,
    ));
    notifyListeners();
  }

  void updateValueFromNomenclature(
      PrintModel printModel, String type, NomenclatureCode code) {
    if (code == NomenclatureCode.paperTypeCode) {
      kPaperType.forEach((k, v) {
        if (v == type) printModel.paperType = k;
      });
    }
    if (code == NomenclatureCode.paperFormatCode) {
      kPaperFormat.forEach((k, v) {
        if (v == type) {
          for (PaperDimensions dim in kDefaultFormats) {
            if (dim.format == k) {
              printModel.paperFormat = dim;
            }
          }
        }
      });
    }
    printModel.refreshPrices();
    notifyListeners();
  }

  void updateCuts(PrintModel printModel) {
    printModel.toggleAddCut();
    printModel.refreshPrices();
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

  void updateDimensions(PrintModel printModel, String l, String h) {
    try {
      double widthL = double.parse(l);
      double lengthH = double.parse(h);
      printModel.paperFormat.widthL = widthL;
      printModel.paperFormat.lengthH = lengthH;
      printModel.refreshPrices();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
