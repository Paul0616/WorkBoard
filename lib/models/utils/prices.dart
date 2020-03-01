import 'constants.dart';

class Prices {
  Map<PaperType, List<double>> pricesForColor;
  Map<PaperType, List<double>> pricesForBlackAndWhite;

  int _pages = 0;



  Prices(
      {this.pricesForColor,
      this.pricesForBlackAndWhite});

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
