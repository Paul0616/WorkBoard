import 'package:work_board/models/utils/constants.dart';

class ProductModel {
  ProductType type;
  String name = 'Printuri';
  double value = 0;
  int quantity = 0;
  bool isActive = true;

  ProductModel({this.type = ProductType.print});

  String get title {
    String t = '';
    kProductTypes.forEach((k, v) {
      if (k == type) t = v;
    });
    return t;
  }

  double pricePerUnit() {
    return quantity != 0 ? value / quantity : 0;
  }
}
