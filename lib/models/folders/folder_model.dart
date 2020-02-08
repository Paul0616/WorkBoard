import 'package:work_board/models/product_model.dart';
import 'package:work_board/models/utils/print_calculator.dart';

import '../utils/constants.dart';

class FolderModel extends ProductModel {
  bool doubleEdge;
  bool havePatchPocket;
  bool bothSidePrinted;
  bool isPlasticized;
  double printPrice = 0;
  double plasticizingPrice = 0;
  double foldingPrice = 0;
  double pocketsPrice = 0;

  FolderModel(
      {this.isPlasticized,
      this.bothSidePrinted,
      this.doubleEdge,
      this.havePatchPocket})
      : super(type: ProductType.folder);

  void toggleBothSide() {
    bothSidePrinted = !bothSidePrinted;
  }

  void togglePlasticized() {
    isPlasticized = !isPlasticized;
  }

  void toggleDoubleEdge() {
    doubleEdge = !doubleEdge;
  }

  void togglePatchPocket() {
    havePatchPocket = !havePatchPocket;
  }

  void refreshPrices() {
    int folderQuantity = quantity * 2;
    if (bothSidePrinted) folderQuantity *= 2;
    //must multipli with 2 or 4 because calculator get price for A4 and folder is A3
    double paperPrice = (bothSidePrinted ? 4 : 2) *
        PrintPriceCalculator.getPriceForColorA4(
            folderQuantity, PaperType.paper250);

    paperPrice = double.parse(paperPrice.toStringAsFixed(2));
    printPrice = paperPrice * quantity;

    double patchPocketPrice = 0;
    if (havePatchPocket) {
      if (doubleEdge)
        patchPocketPrice = kPatchPocketPrice + 0.5;
      else
        patchPocketPrice = kPatchPocketPrice;
    }
    pocketsPrice = patchPocketPrice * quantity;

    double foldPrice = kFoldingPrice;
    if (doubleEdge) foldPrice *= 2;
    foldingPrice = foldPrice * quantity;

    double plasticPrice = 0;
    if (isPlasticized) {
      if (quantity < 25 && quantity > 0)
        plasticPrice = 25.0;
      else
        plasticPrice = kPlasticizingA3Price * quantity;
    }
    plasticizingPrice = plasticPrice;
    value =
        quantity * (paperPrice + patchPocketPrice + foldPrice) + plasticPrice;
  }
}
