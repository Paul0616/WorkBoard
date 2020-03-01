import 'dart:async';

import 'package:work_board/models/book/book_model.dart';
import 'package:work_board/models/folders/folder_model.dart';
import 'package:work_board/models/prints/print_model.dart';

import 'package:work_board/models/utils/constants.dart';
import 'package:work_board/models/utils/prices.dart';
import 'package:work_board/models/visitCard/visit_card_model.dart';

import 'package:work_board/src/bloc/repository/repo_interface.dart';

import 'base_bloc.dart';

class ProductBloc extends Bloc {
  Prices _prices = Prices(
      pricesForColor: _initZeroPrices(),
      pricesForBlackAndWhite: _initZeroPrices());
  final DataSource _dataSource;

  final List<dynamic> _products = [
    PrintModel(
      paperType: PaperType.paper80,
      paperFormat: kDefaultFormats[0],
      colorType: ColorTypeBothSides.OneFaceColor,
      addCut: false,
    ),
  ];

  //Create controllers that allows this stream to be listened to multiple times.
  final StreamController<List<dynamic>> _productsController =
      StreamController<List<dynamic>>.broadcast();
  final StreamController<ProductType> _changeProductTypeController =
      StreamController<ProductType>.broadcast();

//  final StreamController<dynamic> _addProductController =
//      StreamController<dynamic>();
//  final StreamController<dynamic> _updateProductController =
//      StreamController<dynamic>();

  /* ---------------------------
    INPUT stream. We add our products to the stream using this variable.
   --------------------------- */
  StreamSink<List<dynamic>> get _inProducts => _productsController.sink;
  StreamSink<ProductType> get inChangeProductType => _changeProductTypeController.sink;

  /* ---------------------------
    OUTPUT stream. This one will be used within our view to display the products.
   --------------------------- */
  Stream<List<dynamic>> get products => _productsController.stream;
  Stream<ProductType> get currentType => _changeProductTypeController.stream;

  ProductBloc(this._dataSource) {
    _loadPrices();

    _changeProductTypeController.stream.listen(getCurrentProducts);
    inChangeProductType.add(ProductType.print);
    //getCurrentProducts(_currentType);
  }

  void _loadPrices() async {
    try {
      _prices = await _dataSource.getPrices();
      print(_prices.forPrint(type: PaperType.paper80, pages:100, color: ColorTypeOneSide.Color));
    } catch (e) {
      print(e.toString());
    }
  }

  void getCurrentProducts(ProductType type) {
    print(type);
    _inProducts.add(
        _products.where((product) => product.type == type).toList());
  }

  @override
  void dispose() {
    print('DISPOSE');
    _productsController?.close();
    _changeProductTypeController?.close();
//    _addProductController?.close();
//    _updateProductController?.close();
    _dataSource.dispose();
  }

  static Map<PaperType, List<double>> _initZeroPrices() {
    Map<PaperType, List<double>> result = new Map<PaperType, List<double>>();
    PaperType.values.forEach((type) {
      result[type] = List.generate(5, (i) => 0.0);
    });
    return result;
  }
}


