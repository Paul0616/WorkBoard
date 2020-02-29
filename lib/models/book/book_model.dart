import 'package:work_board/models/product_model.dart';
import 'package:work_board/models/utils/print_calculator.dart';

import '../paper_dimension.dart';
import '../utils/constants.dart';

class BookModel extends ProductModel {
  PaperType paperTypeInside;
  PaperType paperTypeCovers;
  PaperDimensions paperFormat;
  ColorTypeBookInside colorTypeBookInside;
  List<ColorTypeBookCovers> colorTypeBookCovers;
  int insidePageCountMultiple4;
  Binding binding;
  CoversPlasticizing coversPlasticizing;

  int fitsOnA3 = 1;
  bool spiralBindingOnly = true;
  String fitsDescription = '';
  int interiorPrints = 0;
  double printPriceInteriorColored = 0;
  double printPriceInteriorGray = 0;
  double printPriceCoverColored = 0;
  double printPriceCoverGray = 0;
  double priceUnprinted = 0;
  int printA4CoverColored = 0;
  int printA4CoverGray = 0;

  BookModel(
      {this.paperTypeInside = PaperType.paper80,
      this.paperTypeCovers = PaperType.paper250,
      this.paperFormat,
      this.colorTypeBookInside = ColorTypeBookInside.Color,
      this.colorTypeBookCovers,
      this.insidePageCountMultiple4 = 0,
      this.binding = Binding.SpiralBindingPortrait,
      this.coversPlasticizing = CoversPlasticizing.None})
      : super(type: ProductType.book);

  String getPaperTypeName(PaperType paperType) {
    return kPaperType[paperType];
  }

  String get getColorIcon1 => kCovertColorIcons1[ColorTypeBookCovers.values
      .firstWhere((element) => element == colorTypeBookCovers[0])
      .index];

  String get getColorIcon2 => kCovertColorIcons2[ColorTypeBookCovers.values
      .firstWhere((element) => element == colorTypeBookCovers[1])
      .index];

  String get getColorIconDouble =>
      kCovertColorDoubleIcons[ColorTypeBookCovers.values
          .firstWhere((element) => element == colorTypeBookCovers[0])
          .index];

  void coversPrint() {
    int colored = 0;
    int grays = 0;
    int unprinted = 0;
    for (ColorTypeBookCovers face in colorTypeBookCovers) {
      switch (face) {
        case ColorTypeBookCovers.Unprinted:
          unprinted +=1;
          break;
        case ColorTypeBookCovers.OneFaceColor:
          colored += 1;
          break;
        case ColorTypeBookCovers.OneFaceBlackWhite:
          grays += 1;
          break;
        case ColorTypeBookCovers.TwoFacesColor:
          colored += 2;
          break;
        case ColorTypeBookCovers.TwoFacesBlackWhite:
          grays += 2;
          break;
        case ColorTypeBookCovers.OneFaceColorOneBlackWhiteColor:
          colored += 1;
          grays += 1;
          break;
      }
    }
    priceUnprinted = unprinted * kUnprinted[paperTypeCovers] * quantity;
    if (fitsOnA3 != 0) {
      printA4CoverColored = (colored * quantity / fitsOnA3).ceil();
      if (binding != Binding.Stapling) printA4CoverColored *= 2;

      printA4CoverGray = (grays * quantity / fitsOnA3).ceil();
      if (binding != Binding.Stapling) printA4CoverGray *= 2;
    } else {
      printA4CoverColored = (colored * quantity * 3).ceil();
      printA4CoverGray = (grays * quantity * 3).ceil();
    }

    printPriceCoverColored =  prices.forPrint(type: paperTypeCovers, pages: printA4CoverColored, color: ColorTypeOneSide.Color);
    //PrintPriceCalculator.getPriceForColorA4(printA4CoverColored, paperTypeCovers);
    printPriceCoverGray = prices.forPrint(type: paperTypeCovers, pages: printA4CoverGray, color: ColorTypeOneSide.BlackWhite);
        //PrintPriceCalculator.getPriceForBlackWhiteA4(printA4CoverGray, paperTypeCovers);
  }

  void nextStateIconDouble() {
    colorTypeBookCovers[0] = ColorTypeBookCovers.values[(ColorTypeBookCovers
                .values
                .firstWhere((element) => element == colorTypeBookCovers[0])
                .index +
            1) %
        kCovertColorDoubleIcons.length];
    colorTypeBookCovers[1] = colorTypeBookCovers[0];
  }

  void nextStateIcon1() {
    colorTypeBookCovers[0] = ColorTypeBookCovers.values[(ColorTypeBookCovers
                .values
                .firstWhere((element) => element == colorTypeBookCovers[0])
                .index +
            1) %
        kCovertColorIcons1.length];
  }

  void nextStateIcon2() {
    colorTypeBookCovers[1] = ColorTypeBookCovers.values[(ColorTypeBookCovers
                .values
                .firstWhere((element) => element == colorTypeBookCovers[1])
                .index +
            1) %
        kCovertColorIcons2.length];
  }

  void toggleSpiralBinding() {
    switch (binding) {
      case Binding.SpiralBindingPortrait:
        binding = Binding.SpiralBindingLandscape;
        break;
      case Binding.SpiralBindingLandscape:
        binding = Binding.SpiralBindingPortrait;
        break;
      default:
        binding = Binding.SpiralBindingPortrait;
        break;
    }
  }

  void setStaplingBinding() {
    binding = Binding.Stapling;
    colorTypeBookCovers[1] = colorTypeBookCovers[0];
  }

  void setBondingBinding() {
    binding = Binding.Bonding;
    colorTypeBookCovers[1] = colorTypeBookCovers[0];
  }

  void setColorTypeInterior(ColorTypeBookInside val) {
    colorTypeBookInside = val;
  }

  void refreshPrices() {
    Fits result = PrintPriceCalculator.getA3FitCount(this);
    if (paperFormat.format == PaperFormatEnum.A3 ||
        paperFormat.format == PaperFormatEnum.Banner) {
      spiralBindingOnly = true;
      binding = Binding.SpiralBindingPortrait;
    } else
      spiralBindingOnly = false;

    fitsOnA3 = result.fitsCount;//int.parse(result['fitCount']);
    fitsDescription = result.toString();//result['description'];
    interiorPrints = PrintPriceCalculator.countInteriorsForPrinting(this);
    if (colorTypeBookInside == ColorTypeBookInside.HalfColorHalfBlackWhite)
      interiorPrints = (interiorPrints / 2).ceil();

    printPriceInteriorColored = prices.forPrint(type: paperTypeInside, pages: interiorPrints, color: ColorTypeOneSide.Color);
        //PrintPriceCalculator.getPriceForColorA4(interiorPrints, paperTypeInside);
    printPriceInteriorGray = prices.forPrint(type: paperTypeInside, pages: interiorPrints, color: ColorTypeOneSide.BlackWhite);
        //PrintPriceCalculator.getPriceForBlackWhiteA4(interiorPrints, paperTypeInside);
    switch (colorTypeBookInside) {
      case ColorTypeBookInside.BlackWhite:
        value = interiorPrints * printPriceInteriorGray;
        break;
      case ColorTypeBookInside.Color:
        value = interiorPrints * printPriceInteriorColored;
        break;
      case ColorTypeBookInside.HalfColorHalfBlackWhite:
        value = interiorPrints * printPriceInteriorGray +
            interiorPrints * printPriceInteriorColored;
        break;
    }
    coversPrint();
    value += printA4CoverColored * printPriceCoverColored +
        printA4CoverGray * printPriceCoverGray + priceUnprinted;
  }
}
