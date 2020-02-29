import 'package:flutter_test/flutter_test.dart';
import 'package:work_board/models/paper_dimension.dart';
import 'package:work_board/models/prints/print_model.dart';
import 'package:work_board/models/utils/constants.dart';
import 'package:work_board/models/utils/print_calculator.dart';

void main() {
  test('unit test pentru calcul cate formate lxh incap pe A3', () {
    final model = PrintModel(
      paperType: PaperType.paper80,
      paperFormat: PaperDimensions(format: PaperFormatEnum.LxH, L: 47, H: 40),
      colorType: ColorTypePrints.OneFaceColor,
      addCut: false,
    );

    Fits fits = PrintPriceCalculator.getA3FitCount(model);

    expect(fits.toString(),
        '7 x 8 plus 6 x 1 / Încap 56 formate plus 6 fibra inversă');
  });
}
