import 'package:work_board/constants.dart';
import 'package:work_board/models/product_model.dart';

class VisitCardPrintModel extends ProductModel {
  bool isSpecialPaper;
  bool bothSidePrinted;
  bool isPlasticized;



  VisitCardPrintModel({this.isSpecialPaper, this.bothSidePrinted, this.isPlasticized, ProductType type}):super(type: type);


}
