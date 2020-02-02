import 'package:work_board/constants.dart';

class ProductModel {
  ProductType type;
  String name = 'Printuri';
  double value = 0;
  int quantity = 0;
  bool isActive = true;


  ProductModel({this.type = ProductType.print});
}
