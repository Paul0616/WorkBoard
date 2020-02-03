import 'package:work_board/constants.dart';
import 'package:work_board/models/product_model.dart';

class VisitCardModel extends ProductModel {
  bool isSpecialPaper;
  bool bothSidePrinted;
  bool isPlasticized;

  VisitCardModel(
      {this.isSpecialPaper,
      this.bothSidePrinted,
      this.isPlasticized,
      ProductType type})
      : super(type: type);

  void refreshPrices() {
    double price = kVisitCardBasePrice;
    if (isSpecialPaper) price += 0.1;
    if (bothSidePrinted) {
      if (isPlasticized)
        price += 0.5 * kVisitCardBasePrice + 0.05;
      else
        price += 0.5 * kVisitCardBasePrice;
    } else {
      if (isPlasticized) price += 0.05;
    }
    value = quantity * price;
  }

  void toggleBothSide() {
    bothSidePrinted = !bothSidePrinted;
  }

  void togglePlasticized() {
    isPlasticized = !isPlasticized;
    if (isPlasticized) isSpecialPaper = false;
  }

  void toggleSpecialPaper() {
    isSpecialPaper = !isSpecialPaper;
    if (isSpecialPaper) isPlasticized = false;
  }
}
