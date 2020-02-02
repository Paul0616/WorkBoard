import 'package:flutter/material.dart';
import 'package:work_board/constants.dart';
import 'package:work_board/models/paper_dimension.dart';
import 'package:work_board/models/print_model.dart';

class PrintData with ChangeNotifier {
  //ProductType productType = ProductType.print;

  List<PrintModel> products = [
    PrintModel(
      paperType: PaperType.paper80,
      paperFormat: kDefaultFormats[0],
      colorType: ColorType.OneFaceColor,
      addCut: false,
    ),
  ];

  int get productCount {
    return products.length;
  }

  double get allPrintsValue {
    double sum = 0;
    for (PrintModel printModel in products) {
      sum += printModel.value;
    }
    return sum;
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
