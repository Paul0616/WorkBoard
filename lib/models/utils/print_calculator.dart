import 'package:flutter/material.dart';
import 'package:work_board/models/book/book_model.dart';
import 'constants.dart';

class PrintPriceCalculator {

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

  int get totalCount => (this.fits.width == 0 || this.fits.height == 0) ? 0 : fitsCount + extraFitsCount;

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
