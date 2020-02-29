import 'constants.dart';

class Prices {
  Map<PaperType, List<double>> pricesForColor;
  Map<PaperType, List<double>> pricesForBlackAndWhite;

  int _pages = 0;

  static const Map<PaperType, List<double>> _defaultPrintPricesForColor = {
    PaperType.paper80: [1.4, 1.30, 1.20, 1.1, 0.95],
    PaperType.paper115: [1.6, 1.5, 1.4, 1.3, 1.05],
    PaperType.paper150: [1.7, 1.6, 1.5, 1.4, 1.2],
    PaperType.paper250: [1.8, 1.7, 1.6, 1.5, 1.25],
    PaperType.paperSticker: [2.1, 2.0, 1.9, 1.7, 1.5],
    PaperType.paperSpecial: [2.2, 2.1, 2.0, 1.9, 1.75],
  };

  static const Map<PaperType, List<double>>
      _defaultPrintPricesForBlackAndWhite = {
    PaperType.paper80: [0.35, 0.3, 0.25, 0.23, 0.18],
    PaperType.paper115: [0.55, 0.5, 0.45, 0.4, 0.33],
    PaperType.paper150: [0.65, 0.6, 0.55, 0.45, 0.38],
    PaperType.paper250: [0.75, 0.7, 0.6, 0.5, 0.43],
    PaperType.paperSticker: [0.85, 0.75, 0.65, 0.55, 0.48],
    PaperType.paperSpecial: [1.15, 1.1, 1.05, 1.05, 1],
  };

  Prices(
      {this.pricesForColor = _defaultPrintPricesForColor,
      this.pricesForBlackAndWhite = _defaultPrintPricesForBlackAndWhite});

  int get _priceLevel {
    if (_pages <= 5) return 1;
    if (_pages > 5 && _pages <= 20) return 2;
    if (_pages > 20 && _pages <= 100) return 3;
    if (_pages > 100 && _pages <= 300) return 4;
    if (_pages > 300) return 5;
    return 0;
  }

  double _linearDecreasePrice(List<double> prices, int priceLevel) {
    double price;
    switch (priceLevel) {
      case 1:
        {
          price = prices[0] + ((_pages - 1) * (prices[1] - prices[0]) / 5);
          if (_pages == 0) price = 0;
        }
        break;
      case 2:
        price = prices[1] + ((_pages - 6) * (prices[2] - prices[1]) / 15);
        break;
      case 3:
        price = prices[2] + ((_pages - 21) * (prices[3] - prices[2]) / 80);
        break;
      case 4:
        price = prices[3] + ((_pages - 101) * (prices[4] - prices[3]) / 200);
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

  double forPrint({PaperType type, int pages, ColorTypeOneSide color}) {
    _pages = pages;
    return double.parse(_linearDecreasePrice(
            // ignore: unrelated_type_equality_checks
            color == ColorTypeOneSide.Color
                ? pricesForColor[type]
                : pricesForBlackAndWhite[type],
            _priceLevel)
        .toStringAsFixed(2));
  }
}
