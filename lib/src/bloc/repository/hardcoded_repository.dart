
import 'package:work_board/models/utils/constants.dart';
import 'package:work_board/models/utils/prices.dart';
import 'package:work_board/src/bloc/repository/repo_interface.dart';


class HardcodedPricesRepository implements DataSource {
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

  @override
  Future<Prices> getPrices() async {
    var result = await Future.delayed(Duration(milliseconds: 500), (){
      return Prices(pricesForColor: _defaultPrintPricesForColor, pricesForBlackAndWhite: _defaultPrintPricesForBlackAndWhite);
    });
    return result;
  }

  @override
  void dispose() {
    // TODO: implement dispose http.close
  }

}
