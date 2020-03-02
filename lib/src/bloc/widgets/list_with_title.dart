import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/models/utils/constants.dart';
import 'package:work_board/src/bloc/blocs/product_bloc.dart';

class ListWithTitle extends StatelessWidget {
  ListWithTitle({
    @required this.listTitle,
    @required this.model,
    @required this.nomenclatureValues,
    @required this.code,
  });

  final String listTitle;
  final dynamic model;
  final List<String> nomenclatureValues;
  final NomenclatureCode code;

  @override
  Widget build(BuildContext context) {
    var _bloc = Provider.of<ProductBloc>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40.0,
        vertical: 40.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            listTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kColorTop,
              fontSize: 30.0,
            ),
          ),
          Container(
            height: kNomenclatureHeight,
            child: ListView.builder(
              itemExtent: 40,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (code != NomenclatureCode.productsCode) {
//                      Provider.of<ProductBloc>(context, listen: false)
//                          .updateValueFromNomenclature(
//                              model, nomenclatureValues[index], code);
                    } else {
                      _bloc.inChangeProductType
                          .add(stringToProductType(nomenclatureValues[index]));
                    }
                    Navigator.pop(context);
                  },
                  child: ListTile(
                    selected: _bloc.productHaveValue(nomenclatureValues[index]),
                    title: Text(
                      nomenclatureValues[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        //color: Colors.black54,
                      ),
                    ),
                  ),
                );
              },
              itemCount: nomenclatureValues.length,
            ),
          ),
        ],
      ),
    );
  }
}
