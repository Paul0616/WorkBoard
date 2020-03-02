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

  static Map<PaperType, List<double>> _initZeroPrices() {
    Map<PaperType, List<double>> result = new Map<PaperType, List<double>>();
    PaperType.values.forEach((type) {
      result[type] = List.generate(5, (i) => 0.0);
    });
    return result;
  }

  //--------------------------------
  final List<dynamic> _products = [
    PrintModel(
      paperType: PaperType.paper80,
      paperFormat: kDefaultFormats[0],
      colorType: ColorTypeBothSides.OneFaceColor,
      addCut: false,
    ),
  ];
  ProductType _currentType = ProductType.print;

  ProductType get currentType => _currentType;

  double get allValue => _products
      .map((product) => product.value)
      .fold(0, (sum, value) => sum + value);

  bool productHaveValue(String title) =>
      _products
          .where((product) => product.type == stringToProductType(title))
          .map((product) => product.value)
          .fold(0, (sum, value) => sum + value) !=
      0;

  // -------------------------------------

  //Create controllers that allows this stream to be listened to multiple times.
  final StreamController<CurrentTypeProducts> _productsController =
      StreamController<CurrentTypeProducts>.broadcast();
  final StreamController<ProductType> _changeProductTypeController =
      StreamController<ProductType>(); //.broadcast();
  final StreamController<ProductType> _addProductController =
      StreamController<ProductType>(); //.broadcast();

//  final StreamController<dynamic> _updateProductController =
//      StreamController<dynamic>();

  /* ---------------------------
    INPUT stream. We add our products to the stream using this variable.
   --------------------------- */
  StreamSink<CurrentTypeProducts> get _inProducts => _productsController.sink;

  StreamSink<ProductType> get inChangeProductType =>
      _changeProductTypeController.sink;

  StreamSink<ProductType> get inAddProductType => _addProductController.sink;

  /* ---------------------------
    OUTPUT stream. This one will be used within our view to display the products.
   --------------------------- */
  Stream<CurrentTypeProducts> get currentProducts => _productsController.stream;

  /*
    CONSTRUCTOR
  */
  ProductBloc(this._dataSource) {
    _loadPrices();
    _changeProductTypeController.stream.listen(_getCurrentProducts);
    _addProductController.stream.listen(_addProduct);
    inChangeProductType.add(ProductType.print);
  }

  void _loadPrices() async {
    try {
      _prices = await _dataSource.getPrices();
      print(_prices.forPrint(
          type: PaperType.paper80, pages: 100, color: ColorTypeOneSide.Color));
    } catch (e) {
      print(e.toString());
    }
  }

  void _getCurrentProducts(ProductType type) {
    print(type);
    _currentType = type;
    _inProducts.add(CurrentTypeProducts(
        _products.where((product) => product.type == type).toList(), type));
  }

  void _addProduct(ProductType type) {
    switch (type) {
      case ProductType.book:
        _products.add(BookModel(
          paperFormat: kDefaultFormats[0],
          colorTypeBookCovers: [
            ColorTypeBookCovers.TwoFacesColor,
            ColorTypeBookCovers.TwoFacesColor,
          ],
        ));
        break;
      case ProductType.print:
        _products.add(PrintModel(
          paperType: PaperType.paper80,
          paperFormat: kDefaultFormats[0],
          colorType: ColorTypeBothSides.OneFaceColor,
          addCut: false,
        ));
        break;
      case ProductType.visit_card:
        _products.add(VisitCardModel(
          isSpecialPaper: false,
          bothSidePrinted: false,
          isPlasticized: false,
        ));
        break;
      case ProductType.folder:
        _products.add(FolderModel(
          doubleEdge: false,
          bothSidePrinted: false,
          isPlasticized: true,
          havePatchPocket: true,
        ));
        break;
      case ProductType.poster:
        // TODO: Handle this case.
        break;
      case ProductType.big_print:
        // TODO: Handle this case.
        break;
      case ProductType.wall_sticker:
        // TODO: Handle this case.
        break;
      case ProductType.cut_sheets:
        // TODO: Handle this case.
        break;
      case ProductType.cut_paper_sticker:
        // TODO: Handle this case.
        break;
      case ProductType.engraving:
        // TODO: Handle this case.
        break;
      case ProductType.textile_printing:
        // TODO: Handle this case.
        break;
      case ProductType.finishing:
        // TODO: Handle this case.
        break;
    }
    _getCurrentProducts(type);
  }

  @override
  void dispose() {
    print('DISPOSE');
    _productsController?.close();
    _changeProductTypeController?.close();
    _addProductController?.close();
//    _updateProductController?.close();
    _dataSource.dispose();
  }
}

class CurrentTypeProducts {
  final List<dynamic> products;
  final ProductType productType;

  CurrentTypeProducts(this.products, this.productType);
}
