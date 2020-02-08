import 'package:flutter/cupertino.dart';

import 'utils/constants.dart';

class PaperDimensions {
  PaperFormatEnum format;
  double lengthH;
  double widthL;

  PaperDimensions(
      {@required this.format, @required double L, @required double H}) {
    widthL = L;
    lengthH = H;
  }
}
