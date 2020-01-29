import 'package:flutter/cupertino.dart';

import '../constants.dart';

class PaperDimensions {
  PaperFormatEnum paperFormat;
  double lengthH;
  double widthL;

  PaperDimensions(
      {@required this.paperFormat, @required double L, @required double H}) {
    widthL = L;
    lengthH = H;
  }
}
