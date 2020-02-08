import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/models/product_data.dart';
import 'package:work_board/models/prints/print_model.dart';

import '../models/utils/constants.dart';

class ListWithTitle extends StatelessWidget {
  ListWithTitle({
    @required this.listTitle,
    @required this.printModel,
    @required this.nomenclatureValues,
    @required this.code,
  });

  final String listTitle;
  final PrintModel printModel;
  final List<String> nomenclatureValues;
  final NomenclatureCode code;

  @override
  Widget build(BuildContext context) {
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
                      Provider.of<ProductData>(context, listen: false)
                          .updateValueFromNomenclature(
                              printModel, nomenclatureValues[index], code);
                    } else {
                      Provider.of<ProductData>(context, listen: false)
                          .changeCurrentProduct(nomenclatureValues[index]);
                    }
                    Navigator.pop(context);
                  },
                  child: ListTile(
                    selected: Provider.of<ProductData>(context)
                        .productHaveValue(nomenclatureValues[index]),
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
