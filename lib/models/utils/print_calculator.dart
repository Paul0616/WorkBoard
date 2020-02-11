import 'package:work_board/models/book/book_model.dart';
import 'constants.dart';

class PrintPriceCalculator {
  static int _getPriceLevel(int pages) {
    if (pages <= 5) return 1;
    if (pages > 5 && pages <= 20) return 2;
    if (pages > 20 && pages <= 100) return 3;
    if (pages > 100 && pages <= 300) return 4;
    if (pages > 300) return 5;
    return 0;
  }

  static double _linearDecreasePrice(
      int pages, List<double> prices, int priceLevel) {
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

  static double getPriceForBlackWhiteA4(int pages, PaperType paperType) {
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

  static double getPriceForColorA4(int pages, PaperType paperType) {
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

//  int cateIncapGeneralizat(Binding binding, BookModel model) {
//    int labelWidth = model.paperFormat.widthL.toInt();
//    int labelHeight = model.paperFormat.lengthH.toInt();
//    if (binding == Binding.Stapling) labelWidth *= 2;
//
//    //WIDTH horizontally on A3 portrait (how many fit on horizontally) exemplu: fitHorizontallyOnA3Portrait=1
//    int fitHorizontallyOnA3Portrait = (297 / labelWidth).floor();
//
//    //how much remain horizontally unprinted | exemplu dimRemainOnHorizontallyA3Portrait=87
//    int dimRemainOnHorizontallyA3Portrait = 297 % labelWidth;
//
//    //HEIGHT vertically on A3 portrait (how many fit on vertically) exemplu: fitVerticallyOnA3Portrait=5
//    int fitVerticallyOnA3Portrait = (420 / labelHeight).floor();
//
//    //how much remain vertically unprinted | exemplu dimRemainOnVerticallyA3Portrait=20
//    int dimRemainOnVerticallyA3Portrait = 420 % labelHeight;
//
//    //how many labels fit in total on the A3 portrait exemplu nr1=5x1=5
//    int nr1 = fitHorizontallyOnA3Portrait * fitVerticallyOnA3Portrait;
//
//    //HEIGHT horizontally on A3 landscape (how many fit on horizontally) | exemplu: fitHorizontallyOnA3landscape=2
//    int fitHorizontallyOnA3landscape = (420 / labelWidth).floor();
//
//    //how much remain horizontally unprinted | exemplu dimRemainOnHorizontallyOnA3Landscape=0
//    int dimRemainOnHorizontallyOnA3Landscape = 420 % labelWidth;
//    //dimRemainOnHorizontallyOnA3Landscape = dimRemainOnHorizontallyOnA3Landscape.toFixed(2);
//
//    //WIDTH vertically on A3 landscape (how many fit on vertically) | exemplu fitVerticallyOnA3Landscape=3
//    int fitVerticallyOnA3Landscape = (297 / labelHeight).floor();
//
//    //how much remain vertically unprinted | exemplu dimRemainVerticallyOnA3Landscape=57
//    int dimRemainVerticallyOnA3Landscape = 297 % labelHeight;
//    //dimRemainVerticallyOnA3Landscape = dimRemainVerticallyOnA3Landscape.toFixed(2);
//
//    //how many labels fit in total on the A3 landscape | exemplu n2=2x3=6
//    int nr2 = fitHorizontallyOnA3landscape * fitVerticallyOnA3Landscape;
//
//    int nr = max(nr1, nr2);
//    int nrplus = 0;
//    int nrsup1 = 0;
//    int nrsup2 = 0;
//    int nrsup = 0;
//    if (nr == nr1) {
//      nrsup1 = (dimRemainOnHorizontallyA3Portrait / labelHeight).floor();
//      nrsup2 = (dimRemainOnVerticallyA3Portrait / labelWidth).floor();
//
//      if (nrsup1 >= nrsup2) {
//        nrplus = (420 / labelWidth).floor();
//        nrsup = nrsup1 * nrplus;
//      } else {
//        nrplus = (297 / labelHeight).floor();
//        nrsup = nrsup2 * nrplus;
//      }
//    } else {
//      nrsup1 = (dimRemainOnHorizontallyOnA3Landscape / labelHeight).floor();
//      nrsup2 = (dimRemainVerticallyOnA3Landscape / labelWidth).floor();
//      if (nrsup1 >= nrsup2) {
//        nrplus = (297 / labelWidth).floor();
//        nrsup = nrsup1 * nrplus;
//      } else {
//        nrplus = (420 / labelHeight).floor();
//        nrsup = nrsup2 * nrplus;
//      }
//    }
//    nr = nr + nrsup;
//    return nr;
//  }

  static Map<String, String> getA3FitCount(dynamic model) {
    int fitCount = 0;
    int labelWidth = model.paperFormat.widthL.toInt();
    int labelHeight = model.paperFormat.lengthH.toInt();
    if (model is BookModel && model.binding == Binding.Stapling)
      labelWidth *= 2;

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

    int nrsup2 = (dimRemainOnVerticallyA3Portrait / labelWidth).floor();

    int nrplus = 0;
    int nrLsup1 = 0;
    int nrHsup1 = 0;
    if (nrsup1 >= nrsup2) {
      nrplus = (420 / labelWidth).floor();

      nrLsup1 = nrplus;
      nrHsup1 = nrsup1;
    } else {
      nrplus = (297 / labelHeight).floor();
      nrLsup1 = nrsup2;
      nrHsup1 = nrplus;
    }

    nrsup1 = (dimRemainOnHorizontallyOnA3Landscape / labelHeight).floor();
    nrsup2 = (dimRemainVerticallyOnA3Landscape / labelWidth).floor();

    int nrLsup2 = 0;
    int nrHsup2 = 0;
    if (nrsup1 >= nrsup2) {
      nrplus = (297 / labelWidth).floor();

      nrLsup2 = nrplus;
      nrHsup2 = nrsup1;
    } else {
      nrplus = (420 / labelHeight).floor();

      nrLsup2 = nrsup2;
      nrHsup2 = nrplus;
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
    result['printCuttingCost'] = (kCuttingPrice *
            (extraFitCount != 0
                ? nrL + nrH + 2 + extraNrL + extraNrH
                : nrL + nrH + 2))
        .toString();
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

  static int countInteriorsForPrinting(BookModel bookModel) {
    int countInteriorForPrinting = 0;
    int sheetsNumber = 0;
    if (bookModel.binding == Binding.Stapling)
      sheetsNumber = (bookModel.insidePageCountMultiple4 / 4).ceil();
    else
      sheetsNumber = (bookModel.insidePageCountMultiple4 / 2).ceil();

    sheetsNumber *= bookModel.quantity;

    if (bookModel.fitsOnA3 != 0) {
      countInteriorForPrinting = (sheetsNumber * 2 / bookModel.fitsOnA3).ceil();
      countInteriorForPrinting *= 2;
    } else {
      if (bookModel.paperFormat.format == PaperFormatEnum.Banner) {
        countInteriorForPrinting =
            bookModel.insidePageCountMultiple4 * 3 * bookModel.quantity;
      } else {
        int nrVert = (220 / bookModel.paperFormat.lengthH).floor();
        countInteriorForPrinting =
            (bookModel.insidePageCountMultiple4 / 2).ceil() *
                bookModel.quantity *
                3 *
                nrVert;
      }
    }
    return countInteriorForPrinting;
  }
}
