import 'package:flutter/material.dart';
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

  static Fits _fitInA3({Size labelSize, Size stripe}) {
    //Size a3 = Size(297, 420);

    int fitHorizontally = (stripe.width / labelSize.width).floor();
    int fitVertically = (stripe.height / labelSize.height).floor();
    Size fits = Size(fitHorizontally.toDouble(), fitVertically.toDouble());

    List<Size> extras = [];

    int extraHorizontally = stripe.width.toInt() % labelSize.width.toInt();
    extras.add(Size(extraHorizontally.toDouble(), stripe.height));

    int extraVertically = stripe.height.toInt() % labelSize.height.toInt();
    extras.add(Size(stripe.width, extraVertically.toDouble()));

    Size fitsExtra = Size(0, 0);
    for (Size extra in extras) {

      int fitExtraHorizontally = (extra.width / labelSize.width).floor();
      int fitExtraVertically = (extra.height / labelSize.height).floor();
      int fitExtraHorizontally1 = (extra.width / labelSize.height).floor();
      int fitExtraVertically1 = (extra.height / labelSize.width).floor();

      if (fitExtraHorizontally * fitExtraVertically >=
          fitExtraHorizontally1 * fitExtraVertically1) {
        if (fitExtraHorizontally * fitExtraVertically >
            fitsExtra.width * fitsExtra.height)
          fitsExtra = Size(
              fitExtraHorizontally.toDouble(), fitExtraVertically.toDouble());
      } else {
        if (fitExtraHorizontally1 * fitExtraVertically1 >
            fitsExtra.width * fitsExtra.height)
          fitsExtra = Size(
              fitExtraHorizontally1.toDouble(), fitExtraVertically1.toDouble());
      }
    }
    return Fits(fits: fits, extraFits: fitsExtra);
  }

  static Fits getA3FitCount(dynamic model) {
    int labelWidth = model.paperFormat.widthL.toInt();
    int labelHeight = model.paperFormat.lengthH.toInt();
    if (model is BookModel && model.binding == Binding.Stapling)
      labelWidth *= 2;
    Fits fits;
    final Fits fits1 =
        _fitInA3(labelSize: Size(labelWidth.toDouble(), labelHeight.toDouble()), stripe: (Size(297,420)));
    final Fits fits2 =
        _fitInA3(labelSize: Size(labelHeight.toDouble(), labelWidth.toDouble()), stripe: (Size(297,420)));
    if (fits1 > fits2)
      fits = fits1;
    else
      fits = fits2;

    Map<String, String> result = {};
    result['printCuttingCost'] = (kCuttingPrice * fits.cuts).toString();
    result['cut'] = '${fits.cuts} taieri';
    result['description'] = fits.toString();
    result['fitCount'] = fits.totalCount.toString();
    return fits;
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

//  static int countCoversForPrinting(BookModel bookModel) {
//    int sheets = 0;
//    if(bookModel.binding == Binding.Stapling)
//      sheets = bookModel.
//  }
}

class Fits {
  Size fits;
  Size extraFits;

  Fits({this.fits, this.extraFits});

  bool hasExtra() => extraFits.width != 0 && extraFits.height != 0;

  int get fitsCount => (fits.width * fits.height).toInt();

  int get extraFitsCount => (extraFits.width * extraFits.height).toInt();

  int get totalCount => fitsCount + extraFitsCount;

  @override
  String toString() => (this.fits.width == 0 || this.fits.height == 0)
      ? 'Formatul e mai mare decât A3.'
      : hasExtra()
          ? '${fits.width.toInt()} x ${fits.height.toInt()} plus ${extraFits.width.toInt()} x ${extraFits.height.toInt()} / Încap $fitsCount formate plus $extraFitsCount fibra inversă'
          : '${fits.width.toInt()} x ${fits.height.toInt()}';

  int get cuts =>
      (fits.width + fits.height + extraFits.width + extraFits.height).toInt() +
      2;

  bool operator >(Fits other) => this.totalCount > other.totalCount;
}
