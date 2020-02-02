import 'package:work_board/constants.dart';
import 'package:work_board/models/paper_dimension.dart';
import 'package:work_board/models/product_model.dart';

class PrintModel extends ProductModel {
  PaperType paperType;
  PaperDimensions paperFormat;
  ColorType colorType;
  bool addCut;
  int printCountColored = 0;
  int printCountGray = 0;
  double printPriceColored = 0;
  double printPriceGray = 0;
  double printCuttingCost = 0;

  PrintModel(
      {this.paperType, this.paperFormat, this.colorType, this.addCut = false});

  String getPaperTypeName() {
    return kPaperType[paperType];
  }

  bool _isDoubleSided() {
    return colorType != ColorType.OneFaceBlackWhite &&
        colorType != ColorType.OneFaceColor;
  }

  bool _isBanner() {
    return paperFormat.format == PaperFormatEnum.Banner;
  }

  bool _isColored() {
    return colorType != ColorType.TwoFacesBlackWhite &&
        colorType != ColorType.OneFaceBlackWhite;
  }

  bool _bothSidesAreTheSame() {
    return colorType == ColorType.TwoFacesColor ||
        colorType == ColorType.TwoFacesBlackWhite;
  }

  void toggleAddCut() {
    addCut = !addCut;
  }

  void toggleTwoFaces() {
    switch (colorType) {
      case ColorType.OneFaceColor:
        colorType = ColorType.OneFaceBlackWhiteOneFaceColorWithFirstColor;
        break;
      case ColorType.OneFaceBlackWhite:
        colorType = ColorType.OneFaceBlackWhiteOneFaceColorWithFirstBlack;
        break;
      case ColorType.TwoFacesColor:
        colorType = ColorType.OneFaceColor;
        break;
      case ColorType.TwoFacesBlackWhite:
        colorType = ColorType.OneFaceBlackWhite;
        break;
      case ColorType.OneFaceBlackWhiteOneFaceColorWithFirstBlack:
        colorType = ColorType.OneFaceBlackWhite;
        break;
      case ColorType.OneFaceBlackWhiteOneFaceColorWithFirstColor:
        colorType = ColorType.OneFaceColor;
        break;
    }
  }

  void toggleFaceColor(bool firstFace) {
    switch (colorType) {
      case ColorType.OneFaceColor:
        colorType = ColorType.OneFaceBlackWhite;
        break;
      case ColorType.OneFaceBlackWhite:
        colorType = ColorType.OneFaceColor;
        break;
      case ColorType.TwoFacesColor:
        if (firstFace) {
          colorType = ColorType.OneFaceBlackWhiteOneFaceColorWithFirstBlack;
        } else {
          colorType = ColorType.OneFaceBlackWhiteOneFaceColorWithFirstColor;
        }
        break;
      case ColorType.TwoFacesBlackWhite:
        if (firstFace) {
          colorType = ColorType.OneFaceBlackWhiteOneFaceColorWithFirstColor;
        } else {
          colorType = ColorType.OneFaceBlackWhiteOneFaceColorWithFirstBlack;
        }
        break;
      case ColorType.OneFaceBlackWhiteOneFaceColorWithFirstBlack:
        if (firstFace)
          colorType = ColorType.TwoFacesColor;
        else
          colorType = ColorType.TwoFacesBlackWhite;
        break;
      case ColorType.OneFaceBlackWhiteOneFaceColorWithFirstColor:
        if (firstFace)
          colorType = ColorType.TwoFacesBlackWhite;
        else
          colorType = ColorType.TwoFacesColor;
        break;
    }
  }

  int _printsCountA4() {
    int printA4 = 0;
    try {
      int printOnA3 = int.parse(getA3FitCount()['fitCount']);
      if (!_isBanner())
        printA4 = (quantity / printOnA3 * 2).ceil();
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
    //int prints = printsCountA4();
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
    //int prints = printsCountA4();
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

  int _getPriceLevel(int pages) {
    if (pages <= 5) return 1;
    if (pages > 5 && pages <= 20) return 2;
    if (pages > 20 && pages <= 100) return 3;
    if (pages > 100 && pages <= 300) return 4;
    if (pages > 300) return 5;
    return 0;
  }

  double _linearDecreasePrice(int pages, List<double> prices, int priceLevel) {
    double price;
    switch (priceLevel) {
      case 1:
        {
          price = prices[0] + ((pages - 1) * (prices[1] - prices[0]) / 5);
          if (pages == 0) price = 0;
        }
        break;
      case 2:
        price = prices[1] + ((pages - 6) * (prices[2] - prices[1]) / 15);
        break;
      case 3:
        price = prices[2] + ((pages - 21) * (prices[3] - prices[2]) / 80);
        break;
      case 4:
        price = prices[3] + ((pages - 101) * (prices[4] - prices[3]) / 200);
        break;
      case 5:
        price = prices[4];
        break;
      default:
        price = 0;
        break;
    }
    return price;
  }

  double _getPriceForBlackWhiteA4(int pages, PaperType paperType) {
    double price = 0;
    switch (paperType) {
      case PaperType.paper80:
        price = _linearDecreasePrice(pages, preturiAN80, _getPriceLevel(pages));
        break;
      case PaperType.paper115:
        price =
            _linearDecreasePrice(pages, preturiAN115, _getPriceLevel(pages));
        break;
      case PaperType.paper150:
        price =
            _linearDecreasePrice(pages, preturiAN150, _getPriceLevel(pages));
        break;
      case PaperType.paper250:
        price =
            _linearDecreasePrice(pages, preturiAN250, _getPriceLevel(pages));
        break;
      case PaperType.paperSticker:
        price = _linearDecreasePrice(pages, preturiANac, _getPriceLevel(pages));
        break;
      case PaperType.paperSpecial:
        price = _linearDecreasePrice(pages, preturiANcs, _getPriceLevel(pages));
        break;
    }
    return price;
  }

  double _getPriceForColorA4(int pages, PaperType paperType) {
    double price = 0;
    switch (paperType) {
      case PaperType.paper80:
        price =
            _linearDecreasePrice(pages, preturiColor80, _getPriceLevel(pages));
        break;
      case PaperType.paper115:
        price =
            _linearDecreasePrice(pages, preturiColor115, _getPriceLevel(pages));
        break;
      case PaperType.paper150:
        price =
            _linearDecreasePrice(pages, preturiColor150, _getPriceLevel(pages));
        break;
      case PaperType.paper250:
        price =
            _linearDecreasePrice(pages, preturiColor250, _getPriceLevel(pages));
        break;
      case PaperType.paperSticker:
        price =
            _linearDecreasePrice(pages, preturiColorac, _getPriceLevel(pages));
        break;
      case PaperType.paperSpecial:
        price =
            _linearDecreasePrice(pages, preturiColorcs, _getPriceLevel(pages));
        break;
    }
    return price;
  }

  void refreshPrices() {
    int prints = _printsCountA4();
    printCountColored = _printsCountColorA4(prints);
    print('REFRESH');
    printCountGray = _printsCountBlackWhiteA4(prints);

    printPriceColored = double.parse(
        _getPriceForColorA4(printCountColored, paperType).toStringAsFixed(2));

    printPriceGray = double.parse(
        _getPriceForBlackWhiteA4(printCountGray, paperType).toStringAsFixed(2));

    value = printCountColored * printPriceColored +
        printCountGray * printPriceGray +
        (addCut ? printCuttingCost : 0);
  }

  Map<String, String> getA3FitCount() {
    int fitCount = 0;
    int labelWidth = paperFormat.widthL.toInt();
    int labelHeight = paperFormat.lengthH.toInt();

    //WIDTH horizontally on A3 portrait (how many fit on horizontally) exemplu: fitHorizontallyOnA3Portrait=1
    int fitHorizontallyOnA3Portrait = (297 / labelWidth).floor();

    //how much remain horizontally unprinted | exemplu dimRemainOnHorizontallyA3Portrait=87
    int dimRemainOnHorizontallyA3Portrait = 297 % labelWidth;

    //HEIGHT vertically on A3 portrait (how many fit on vertically) exemplu: fitVerticallyOnA3Portrait=5
    int fitVerticallyOnA3Portrait = (420 / labelHeight).floor();

    //how much remain vertically unprinted | exemplu dimRemainOnVerticallyA3Portrait=20
    int dimRemainOnVerticallyA3Portrait = 420 % labelHeight;

    //how many labels fit in total on the A3 portrait exemplu nr1=5x1=5
    int nr1 = fitHorizontallyOnA3Portrait * fitVerticallyOnA3Portrait;

    //HEIGHT horizontally on A3 landscape (how many fit on horizontally) | exemplu: fitHorizontallyOnA3landscape=2
    int fitHorizontallyOnA3landscape = (420 / labelWidth).floor();

    //how much remain horizontally unprinted | exemplu dimRemainOnHorizontallyOnA3Landscape=0
    int dimRemainOnHorizontallyOnA3Landscape = 420 % labelWidth;
    //dimRemainOnHorizontallyOnA3Landscape = dimRemainOnHorizontallyOnA3Landscape.toFixed(2);

    //WIDTH vertically on A3 landscape (how many fit on vertically) | exemplu fitVerticallyOnA3Landscape=3
    int fitVerticallyOnA3Landscape = (297 / labelHeight).floor();

    //how much remain vertically unprinted | exemplu dimRemainVerticallyOnA3Landscape=57
    int dimRemainVerticallyOnA3Landscape = 297 % labelHeight;
    //dimRemainVerticallyOnA3Landscape = dimRemainVerticallyOnA3Landscape.toFixed(2);

    //how many labels fit in total on the A3 landscape | exemplu n2=2x3=6
    int nr2 = fitHorizontallyOnA3landscape * fitVerticallyOnA3Landscape;

    int nrsup1 = (dimRemainOnHorizontallyA3Portrait / labelHeight).floor();

    /// exemplu 1
    int nrsup2 = (dimRemainOnVerticallyA3Portrait / labelWidth).floor();

    /// exemplu 0
    int nrplus = 0;
    int nrLsup1 = 0;
    int nrHsup1 = 0;
    if (nrsup1 >= nrsup2) {
      nrplus = (420 / labelWidth).floor();

      /// exemplu 2
      nrLsup1 = nrplus; // 2
      nrHsup1 = nrsup1; // 1
    } else {
      nrplus = (297 / labelHeight).floor(); ////// exemplu  2
      nrLsup1 = nrsup2; // 0
      nrHsup1 = nrplus; // 2
    }

    nrsup1 = (dimRemainOnHorizontallyOnA3Landscape / labelHeight)
        .floor(); //// exemplu 0
    nrsup2 = (dimRemainVerticallyOnA3Landscape / labelWidth).floor();

    /// exemplu 0
    int nrLsup2 = 0;
    int nrHsup2 = 0;
    if (nrsup1 >= nrsup2) {
      nrplus = (297 / labelWidth).floor();

      /// exemplu 1
      nrLsup2 = nrplus; // exemplu 1
      nrHsup2 = nrsup1; // exemplu 0
    } else {
      nrplus = (420 / labelHeight).floor();

      /// exemplu 5
      nrLsup2 = nrsup2; // exemplu 0
      nrHsup2 = nrplus; // exemplu 5
    }

    int extraFitCount = 0;
    int extraNrL = 0;
    int extraNrH = 0;
    int nrL = 0;
    int nrH = 0;
    if ((nr1 + (nrLsup1 * nrHsup1)) > (nr2 + (nrLsup2 * nrHsup2))) {
      fitCount = nr1;
      extraFitCount = nrLsup1 * nrHsup1;
      extraNrL = nrLsup1;
      extraNrH = nrHsup1;
      nrL = fitHorizontallyOnA3Portrait;
      nrH = fitVerticallyOnA3Portrait;
    }
    if ((nr1 + (nrLsup1 * nrHsup1)) < (nr2 + (nrLsup2 * nrHsup2))) {
      fitCount = nr2;
      extraFitCount = nrLsup2 * nrHsup2;
      extraNrL = nrLsup2;
      extraNrH = nrHsup2;
      nrL = fitHorizontallyOnA3landscape;
      nrH = fitVerticallyOnA3Landscape;
    }
    if ((nr1 + (nrLsup1 * nrHsup1)) == (nr2 + (nrLsup2 * nrHsup2))) {
      if (nr1 >= nr2) {
        fitCount = nr1;
        extraFitCount = nrLsup1 * nrHsup1;
        extraNrL = nrLsup1;
        extraNrH = nrHsup1;
        nrL = fitHorizontallyOnA3Portrait;
        nrH = fitVerticallyOnA3Portrait;
      } else {
        fitCount = nr2;
        extraFitCount = nrLsup2 * nrHsup2;
        extraNrL = nrLsup2;
        extraNrH = nrHsup2;
        nrL = fitHorizontallyOnA3landscape;
        nrH = fitVerticallyOnA3Landscape;
      }
    }
    Map<String, String> result = {};
    printCuttingCost = kCuttingPrice *
        (extraFitCount != 0
            ? nrL + nrH + 2 + extraNrL + extraNrH
            : nrL + nrH + 2);
    result['cut'] = extraFitCount != 0
        ? '${nrL + nrH + 2 + extraNrL + extraNrH} tăieri'
        : '${nrL + nrH + 2} tăieri';

    result['description'] = extraFitCount != 0
        ? '$nrL x $nrH plus $extraNrL x $extraNrH / Încap $fitCount formate plus $extraFitCount fibra inversă'
        : '$nrL x $nrH';
    if (nrL == 0 || nrH == 0) {
      result['description'] = 'Formatul e mai mare decât A3.';
    }

    fitCount += extraFitCount;
    result['fitCount'] = fitCount.toString();
    return result;
  }
}