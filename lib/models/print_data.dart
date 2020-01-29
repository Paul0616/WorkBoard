import 'package:flutter/material.dart';
import 'package:work_board/constants.dart';
import 'package:work_board/models/paper_dimension.dart';
import 'package:work_board/models/print_model.dart';
import 'package:work_board/models/product_model.dart';

class PrintData with ChangeNotifier {
  //ProductType productType = ProductType.print;
  List<PrintModel> products = [
    PrintModel(),
    PrintModel(
      paperType: PaperType.paper250,
      paperFormat:
          PaperDimensions(paperFormat: PaperFormatEnum.Banner, L: 640, H: 220),
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
//  List<ProductModel> products = {
//
//  }
//  ProductModel productModel = ProductModel();

//  PrintModel get printModel {
//    if (productType == ProductType.print)
//      return productModel;
//    else
//      return null;
//  }
}
