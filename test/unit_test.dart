import 'package:flutter_test/flutter_test.dart';
import 'package:work_board/models/prints/print_model.dart';
import 'package:work_board/models/utils/constants.dart';
import 'package:work_board/models/utils/prices.dart';
import 'package:work_board/models/utils/print_calculator.dart';
import 'package:work_board/src/bloc/blocs/product_bloc.dart';
import 'package:work_board/src/bloc/repository/hardcoded_repository.dart';

void main() {
//  test('unit test pentru calcul cate formate lxh incap pe A3', () {
//    final model = PrintModel(
//      paperType: PaperType.paper80,
//      paperFormat: kDefaultFormats[0],
//      colorType: ColorTypeBothSides.OneFaceColor,
//      addCut: false,
//    );
//
//    Fits fits = PrintPriceCalculator.getA3FitCount(model);
//
//    expect(fits.toString(), '1 x 1');
//    // '7 x 8 plus 6 x 1 / Încap 56 formate plus 6 fibra inversă');
//  });
//
//  test('print prices', () {
//    final prices = Prices();
//
//    expect(
//        prices.forPrint(
//            type: PaperType.paper80, pages: 100, color: ColorTypeOneSide.Color),
//        double.parse(1.104.toStringAsFixed(2)));
//  });

//  test('product bloc', () async {
//    final bloc = ProductBloc(
//      HardcodedPricesRepository(),
//    );
//
//    await expectLater(
//      bloc.currentType,
//      emitsInOrder(const <ProductType>[ProductType.print]),
//    );
//    bloc.dispose();
//  });
}
