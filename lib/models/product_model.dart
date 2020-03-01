import 'package:work_board/models/utils/constants.dart';
import 'package:work_board/models/utils/prices.dart';

class ProductModel {
  ProductType type;
  String name = 'Printuri';
  double value = 0;
  int quantity = 0;
  bool isActive = true;
  Prices prices = Prices();

  bool _showAlert = false;

  ProductModel({this.type = ProductType.print});


  bool get showAlert {
    return _showAlert;
  }
  set showAlert (val) {
    _showAlert = val;
  }

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
