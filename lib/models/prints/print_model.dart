import 'package:work_board/models/utils/constants.dart';
import 'package:work_board/models/paper_dimension.dart';
import 'package:work_board/models/product_model.dart';
import 'package:work_board/models/utils/print_calculator.dart';

class PrintModel extends ProductModel {
  PaperType paperType;
  PaperDimensions paperFormat;
  ColorTypeBothSides colorType;
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
    return colorType != ColorTypeBothSides.OneFaceBlackWhite &&
        colorType != ColorTypeBothSides.OneFaceColor;
  }

  bool _isBanner() {
    return paperFormat.format == PaperFormatEnum.Banner;
  }

  bool _isColored() {
    return colorType != ColorTypeBothSides.TwoFacesBlackWhite &&
        colorType != ColorTypeBothSides.OneFaceBlackWhite;
  }

  bool _bothSidesAreTheSame() {
    return colorType == ColorTypeBothSides.TwoFacesColor ||
        colorType == ColorTypeBothSides.TwoFacesBlackWhite;
  }

  void toggleAddCut() {
    addCut = !addCut;
  }

  void toggleTwoFaces() {
    switch (colorType) {
      case ColorTypeBothSides.OneFaceColor:
        colorType = ColorTypeBothSides.OneFaceBlackWhiteOneFaceColorWithFirstColor;
        break;
      case ColorTypeBothSides.OneFaceBlackWhite:
        colorType = ColorTypeBothSides.OneFaceBlackWhiteOneFaceColorWithFirstBlack;
        break;
      case ColorTypeBothSides.TwoFacesColor:
        colorType = ColorTypeBothSides.OneFaceColor;
        break;
      case ColorTypeBothSides.TwoFacesBlackWhite:
        colorType = ColorTypeBothSides.OneFaceBlackWhite;
        break;
      case ColorTypeBothSides.OneFaceBlackWhiteOneFaceColorWithFirstBlack:
        colorType = ColorTypeBothSides.OneFaceBlackWhite;
        break;
      case ColorTypeBothSides.OneFaceBlackWhiteOneFaceColorWithFirstColor:
        colorType = ColorTypeBothSides.OneFaceColor;
        break;
    }
  }

  void toggleFaceColor(bool firstFace) {
    switch (colorType) {
      case ColorTypeBothSides.OneFaceColor:
        colorType = ColorTypeBothSides.OneFaceBlackWhite;
        break;
      case ColorTypeBothSides.OneFaceBlackWhite:
        colorType = ColorTypeBothSides.OneFaceColor;
        break;
      case ColorTypeBothSides.TwoFacesColor:
        if (firstFace) {
          colorType = ColorTypeBothSides.OneFaceBlackWhiteOneFaceColorWithFirstBlack;
        } else {
          colorType = ColorTypeBothSides.OneFaceBlackWhiteOneFaceColorWithFirstColor;
        }
        break;
      case ColorTypeBothSides.TwoFacesBlackWhite:
        if (firstFace) {
          colorType = ColorTypeBothSides.OneFaceBlackWhiteOneFaceColorWithFirstColor;
        } else {
          colorType = ColorTypeBothSides.OneFaceBlackWhiteOneFaceColorWithFirstBlack;
        }
        break;
      case ColorTypeBothSides.OneFaceBlackWhiteOneFaceColorWithFirstBlack:
        if (firstFace)
          colorType = ColorTypeBothSides.TwoFacesColor;
        else
          colorType = ColorTypeBothSides.TwoFacesBlackWhite;
        break;
      case ColorTypeBothSides.OneFaceBlackWhiteOneFaceColorWithFirstColor:
        if (firstFace)
          colorType = ColorTypeBothSides.TwoFacesBlackWhite;
        else
          colorType = ColorTypeBothSides.TwoFacesColor;
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
   Fits result = PrintPriceCalculator.getA3FitCount(this);
    fitsOnA3 = result.fitsCount;//int.parse(result['fitCount']);
    fitsDescription = result.toString();//result['description'];
    printCuttingCost = result.cuts * kCuttingPrice;//double.parse(result['printCuttingCost']);
    cuts = '${result.cuts} taieri';//result['cut'];

    int prints = _printsCountA4();
    printCountColored = _printsCountColorA4(prints);
    print('REFRESH');
    printCountGray = _printsCountBlackWhiteA4(prints);

    printPriceColored = prices.forPrint(type: paperType, pages: printCountColored, color: ColorTypeOneSide.Color);
        //double.parse(PrintPriceCalculator.getPriceForColorA4(printCountColored, paperType).toStringAsFixed(2));

    printPriceGray = prices.forPrint(type: paperType, pages: printCountGray, color: ColorTypeOneSide.BlackWhite);
        //double.parse(PrintPriceCalculator.getPriceForBlackWhiteA4(printCountGray, paperType).toStringAsFixed(2));

    value = printCountColored * printPriceColored +
        printCountGray * printPriceGray +
        (addCut ? printCuttingCost : 0);
  }

}
