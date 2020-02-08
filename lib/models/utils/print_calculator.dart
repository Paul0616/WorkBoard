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
}
