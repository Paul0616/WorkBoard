import 'package:flutter_test/flutter_test.dart';
import 'package:work_board/models/prints/print_model.dart';
import 'package:work_board/models/utils/constants.dart';
import 'package:work_board/models/utils/prices.dart';
import 'package:work_board/models/utils/print_calculator.dart';
import 'package:work_board/src/bloc/blocs/product_bloc.dart';
import 'package:work_board/src/bloc/repository/hardcoded_repository.dart';

import 'package:mockito/mockito.dart';

class MockProductBloc extends Mock implements ProductBloc {}

void main() {
  test('unit test pentru calcul cate formate lxh incap pe A3', () {
    final model = PrintModel(
      paperType: PaperType.paper80,
      paperFormat: kDefaultFormats[0],
      colorType: ColorTypeBothSides.OneFaceColor,
      addCut: false,
    );

    Fits fits = PrintPriceCalculator.getA3FitCount(model);

    expect(fits.toString(), '1 x 1');
    // '7 x 8 plus 6 x 1 / Încap 56 formate plus 6 fibra inversă');
  });

  test('print prices', () {
    const Map<PaperType, List<double>> _defaultPrintPricesForColor = {
      PaperType.paper80: [1.4, 1.30, 1.20, 1.1, 0.95],
      PaperType.paper115: [1.6, 1.5, 1.4, 1.3, 1.05],
      PaperType.paper150: [1.7, 1.6, 1.5, 1.4, 1.2],
      PaperType.paper250: [1.8, 1.7, 1.6, 1.5, 1.25],
      PaperType.paperSticker: [2.1, 2.0, 1.9, 1.7, 1.5],
      PaperType.paperSpecial: [2.2, 2.1, 2.0, 1.9, 1.75],
    };

    const Map<PaperType, List<double>> _defaultPrintPricesForBlackAndWhite = {
      PaperType.paper80: [0.35, 0.3, 0.25, 0.23, 0.18],
      PaperType.paper115: [0.55, 0.5, 0.45, 0.4, 0.33],
      PaperType.paper150: [0.65, 0.6, 0.55, 0.45, 0.38],
      PaperType.paper250: [0.75, 0.7, 0.6, 0.5, 0.43],
      PaperType.paperSticker: [0.85, 0.75, 0.65, 0.55, 0.48],
      PaperType.paperSpecial: [1.15, 1.1, 1.05, 1.05, 1],
    };
    final prices = Prices(
        pricesForColor: _defaultPrintPricesForColor,
        pricesForBlackAndWhite: _defaultPrintPricesForBlackAndWhite);

    expect(
        prices.forPrint(
            type: PaperType.paper80, pages: 100, color: ColorTypeOneSide.Color),
        double.parse(1.104.toStringAsFixed(2)));
  });

  test('product bloc', () async {
    final bloc = ProductBloc(
      HardcodedPricesRepository(),
    );
    // final bloc = MockProductBloc();
    bloc.inChangeProductType.add(ProductType.print);

    await expectLater(
      bloc.currentProducts,
      emitsInOrder(
          [CurrentTypeProducts(List<PrintModel>(), ProductType.print)]),
    );
    bloc.dispose();
  });
}
