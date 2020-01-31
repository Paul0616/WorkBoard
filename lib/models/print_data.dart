import 'package:flutter/material.dart';
import 'package:work_board/constants.dart';
import 'package:work_board/models/paper_dimension.dart';
import 'package:work_board/models/print_model.dart';

class PrintData with ChangeNotifier {
  //ProductType productType = ProductType.print;

  List<PrintModel> products = [
    PrintModel(
      paperType: PaperType.paper115,
      paperFormat:
          PaperDimensions(format: PaperFormatEnum.A5, L: 148.0, H: 210.0),
      colorType: ColorType.OneFaceBlackWhiteOneFaceColor,
      addCut: false,
    ),
    PrintModel(
      paperType: PaperType.paper250,
      paperFormat:
          PaperDimensions(format: PaperFormatEnum.Banner, L: 640, H: 220),
      colorType: ColorType.TwoFacesBlackWhite,
      addCut: false,
    ),
    PrintModel(
      paperType: PaperType.paper250,
      paperFormat: PaperDimensions(format: PaperFormatEnum.LxH, L: 47, H: 40),
      colorType: ColorType.TwoFacesBlackWhite,
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
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void deletePrintModel(PrintModel printModel) {
    products.remove(printModel);
    notifyListeners();
  }

  void updatePaperType(PrintModel printModel, String type){
    kPaperType.forEach((k,v){
      if(v==type)
        printModel.paperType = k;
    });
    notifyListeners();
  }

  void updateCuts(PrintModel printModel){
    printModel.toggleAddCut();
    notifyListeners();
  }
}
