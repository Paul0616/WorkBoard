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
    ),
    PrintModel(
      paperType: PaperType.paper250,
      paperFormat:
          PaperDimensions(format: PaperFormatEnum.Banner, L: 640, H: 220),
      colorType: ColorType.TwoFacesBlackWhite,
    ),
    PrintModel(
      paperType: PaperType.paper250,
      paperFormat:
      PaperDimensions(format: PaperFormatEnum.LxH, L: 47, H: 40),
      colorType: ColorType.TwoFacesBlackWhite,
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

//  void updateQuantity(){
//
//    notifyListeners();
//  }
}
