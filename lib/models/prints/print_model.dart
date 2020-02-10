import 'package:work_board/models/utils/constants.dart';
import 'package:work_board/models/paper_dimension.dart';
import 'package:work_board/models/product_model.dart';
import 'package:work_board/models/utils/print_calculator.dart';

class PrintModel extends ProductModel {
  PaperType paperType;
  PaperDimensions paperFormat;
  ColorTypePrints colorType;
  bool addCut;
  int printCountColored = 0;
  int printCountGray = 0;
  double printPriceColored = 0;
  double printPriceGray = 0;
  double printCuttingCost = 0;

  int fitsOnA3 = 1;
  String fitsDescription = '';
  String cuts = '4 tăieri';

  PrintModel(
      {this.paperType, this.paperFormat, this.colorType, this.addCut = false});



  String getPaperTypeName() {
    return kPaperType[paperType];
  }

  bool _isDoubleSided() {
    return colorType != ColorTypePrints.OneFaceBlackWhite &&
        colorType != ColorTypePrints.OneFaceColor;
  }

  bool _isBanner() {
    return paperFormat.format == PaperFormatEnum.Banner;
  }

  bool _isColored() {
    return colorType != ColorTypePrints.TwoFacesBlackWhite &&
        colorType != ColorTypePrints.OneFaceBlackWhite;
  }

  bool _bothSidesAreTheSame() {
    return colorType == ColorTypePrints.TwoFacesColor ||
        colorType == ColorTypePrints.TwoFacesBlackWhite;
  }

  void toggleAddCut() {
    addCut = !addCut;
  }

  void toggleTwoFaces() {
    switch (colorType) {
      case ColorTypePrints.OneFaceColor:
        colorType = ColorTypePrints.OneFaceBlackWhiteOneFaceColorWithFirstColor;
        break;
      case ColorTypePrints.OneFaceBlackWhite:
        colorType = ColorTypePrints.OneFaceBlackWhiteOneFaceColorWithFirstBlack;
        break;
      case ColorTypePrints.TwoFacesColor:
        colorType = ColorTypePrints.OneFaceColor;
        break;
      case ColorTypePrints.TwoFacesBlackWhite:
        colorType = ColorTypePrints.OneFaceBlackWhite;
        break;
      case ColorTypePrints.OneFaceBlackWhiteOneFaceColorWithFirstBlack:
        colorType = ColorTypePrints.OneFaceBlackWhite;
        break;
      case ColorTypePrints.OneFaceBlackWhiteOneFaceColorWithFirstColor:
        colorType = ColorTypePrints.OneFaceColor;
        break;
    }
  }

  void toggleFaceColor(bool firstFace) {
    switch (colorType) {
      case ColorTypePrints.OneFaceColor:
        colorType = ColorTypePrints.OneFaceBlackWhite;
        break;
      case ColorTypePrints.OneFaceBlackWhite:
        colorType = ColorTypePrints.OneFaceColor;
        break;
      case ColorTypePrints.TwoFacesColor:
        if (firstFace) {
          colorType = ColorTypePrints.OneFaceBlackWhiteOneFaceColorWithFirstBlack;
        } else {
          colorType = ColorTypePrints.OneFaceBlackWhiteOneFaceColorWithFirstColor;
        }
        break;
      case ColorTypePrints.TwoFacesBlackWhite:
        if (firstFace) {
          colorType = ColorTypePrints.OneFaceBlackWhiteOneFaceColorWithFirstColor;
        } else {
          colorType = ColorTypePrints.OneFaceBlackWhiteOneFaceColorWithFirstBlack;
        }
        break;
      case ColorTypePrints.OneFaceBlackWhiteOneFaceColorWithFirstBlack:
        if (firstFace)
          colorType = ColorTypePrints.TwoFacesColor;
        else
          colorType = ColorTypePrints.TwoFacesBlackWhite;
        break;
      case ColorTypePrints.OneFaceBlackWhiteOneFaceColorWithFirstColor:
        if (firstFace)
          colorType = ColorTypePrints.TwoFacesBlackWhite;
        else
          colorType = ColorTypePrints.TwoFacesColor;
        break;
    }
  }

  int _printsCountA4() {
    int printA4 = 0;
    try {
      if (!_isBanner())
        printA4 = (quantity / fitsOnA3 * 2).ceil();
      else
        printA4 = quantity * 3;

      if (_isDoubleSided()) printA4 *= 2;
    } catch (e) {
      print(e);
    }
    print(
        'countA4 $printA4 Doublesided ${_isDoubleSided()} Colored ${_isColored()} Both ${_bothSidesAreTheSame()}');
    return printA4;
  }

  int _printsCountBlackWhiteA4(int prints) {
    int prBAA4 = 0;

    if (_isDoubleSided()) {
      if (_bothSidesAreTheSame()) {
        if (!_isColored()) {
          prBAA4 = prints;
        }
      } else {
        prBAA4 = (prints ~/ 2).toInt();
      }
    } else if (!_isColored()) {
      prBAA4 = prints;
    }

    return prBAA4;
  }

  int _printsCountColorA4(int prints) {
    int prCA4 = 0;

    if (_isDoubleSided()) {
      if (_bothSidesAreTheSame()) {
        if (_isColored()) {
          prCA4 = prints;
        }
      } else {
        prCA4 = (prints ~/ 2).toInt();
      }
    } else if (_isColored()) {
      prCA4 = prints;
    }

    return prCA4;
  }

  void refreshPrices() {
    Map<String, String> result = PrintPriceCalculator.getA3FitCount(this);
    fitsOnA3 = int.parse(result['fitCount']);
    fitsDescription = result['description'];
    printCuttingCost = double.parse(result['printCuttingCost']);
    cuts = result['cut'];

    int prints = _printsCountA4();
    printCountColored = _printsCountColorA4(prints);
    print('REFRESH');
    printCountGray = _printsCountBlackWhiteA4(prints);

    printPriceColored = double.parse(
        PrintPriceCalculator.getPriceForColorA4(printCountColored, paperType)
            .toStringAsFixed(2));

    printPriceGray = double.parse(
        PrintPriceCalculator.getPriceForBlackWhiteA4(printCountGray, paperType)
            .toStringAsFixed(2));

    value = printCountColored * printPriceColored +
        printCountGray * printPriceGray +
        (addCut ? printCuttingCost : 0);
  }

}
