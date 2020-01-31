import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/models/print_data.dart';
import 'package:work_board/models/print_model.dart';

import '../constants.dart';

class ListWithTitle extends StatelessWidget {
  ListWithTitle({
    @required this.updateText,
    @required this.printModel,
    @required this.nomenclatureValues,
    @required this.code,
  });

  final String updateText;
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
            updateText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kColor2,
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
                    Provider.of<PrintData>(context, listen: false)
                        .updateValueFromNomenclature(
                            printModel, nomenclatureValues[index], code);
                    Navigator.pop(context);
                  },
                  child: ListTile(
                    title: Text(
                      nomenclatureValues[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
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
