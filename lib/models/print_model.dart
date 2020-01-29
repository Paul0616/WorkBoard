import 'package:work_board/constants.dart';
import 'package:work_board/models/paper_dimension.dart';
import 'package:work_board/models/product_model.dart';

class PrintModel extends ProductModel {
  PaperType paperType = PaperType.paper115;
  PaperDimensions paperFormat =
      PaperDimensions(paperFormat: PaperFormatEnum.A5, L: 148.0, H: 210.0);
  ColorType colorType = ColorType.OneFaceBlackWhiteOneFaceColor;

  PrintModel({this.paperType, this.paperFormat, this.colorType});

  String getPaperTypeName() {
    return kPaperType[paperType];
  }
}
