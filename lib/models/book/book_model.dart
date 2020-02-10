import 'package:work_board/models/product_model.dart';
import 'package:work_board/models/utils/print_calculator.dart';

import '../paper_dimension.dart';
import '../utils/constants.dart';

class BookModel extends ProductModel {
  PaperType paperTypeInside;
  PaperType paperTypeCovers;
  PaperDimensions paperFormat;
  ColorTypeBookInside colorTypeBookInside;
  List<ColorTypeBookCovers> colorTypeBookCovers;
  int insidePageCountMultiple4;
  Binding binding;
  CoversPlasticizing coversPlasticizing;


  int fitsOnA3 = 1;
  String fitsDescription = '';
 // int printCountColored = 0;
//  int printCountGray = 0;
//  double printPriceColored = 0;
//  double printPriceGray = 0;
//  double printCuttingCost = 0;

  BookModel(
      {this.paperTypeInside = PaperType.paper80,
      this.paperTypeCovers = PaperType.paper250,
      this.paperFormat,
      this.colorTypeBookInside = ColorTypeBookInside.Color,
      this.colorTypeBookCovers,
      this.insidePageCountMultiple4 = 0,
      this.binding = Binding.SpiralBindingPortrait,
      this.coversPlasticizing = CoversPlasticizing.None})
      : super(type: ProductType.book);

  String getPaperTypeName(PaperType paperType) {
    return kPaperType[paperType];
  }
//  void toggleBothSide() {
//    bothSidePrinted = !bothSidePrinted;
//  }
//
//  void togglePlasticized() {
//    isPlasticized = !isPlasticized;
//  }
//
//  void toggleDoubleEdge() {
//    doubleEdge = !doubleEdge;
//  }
//
//  void togglePatchPocket() {
//    havePatchPocket = !havePatchPocket;
//  }
//
  void refreshPrices() {
    Map<String, String> result = PrintPriceCalculator.getA3FitCount(this);
    fitsOnA3 = int.parse(result['fitCount']);
    fitsDescription = result['description'];
//    int folderQuantity = quantity * 2;
//    if (bothSidePrinted) folderQuantity *= 2;
//    //must multipli with 2 or 4 because calculator get price for A4 and folder is A3
//    double paperPrice = (bothSidePrinted ? 4 : 2) *
//        PrintPriceCalculator.getPriceForColorA4(
//            folderQuantity, PaperType.paper250);
//
//    paperPrice = double.parse(paperPrice.toStringAsFixed(2));
//    printPrice = paperPrice * quantity;
//
//    double patchPocketPrice = 0;
//    if (havePatchPocket) {
//      if (doubleEdge)
//        patchPocketPrice = kPatchPocketPrice + 0.5;
//      else
//        patchPocketPrice = kPatchPocketPrice;
//    }
//    pocketsPrice = patchPocketPrice * quantity;
//
//    double foldPrice = kFoldingPrice;
//    if (doubleEdge) foldPrice *= 2;
//    foldingPrice = foldPrice * quantity;
//
//    double plasticPrice = 0;
//    if (isPlasticized) {
//      if (quantity < 25 && quantity > 0)
//        plasticPrice = 25.0;
//      else
//        plasticPrice = kPlasticizingA3Price * quantity;
//    }
//    plasticizingPrice = plasticPrice;
//    value =
//        quantity * (paperPrice + patchPocketPrice + foldPrice) + plasticPrice;
  }
}
