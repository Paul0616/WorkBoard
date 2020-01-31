import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/models/print_data.dart';
import 'package:work_board/models/print_model.dart';

import '../constants.dart';

class UpdateListScreen extends StatelessWidget {
  final String updateText;
  final PrintModel printModel;
  final List<String> nomenclatureValues;

  UpdateListScreen({this.nomenclatureValues, this.printModel, this.updateText});



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Padding(
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
                height: 200.0,
                child: ListView.builder(
                  itemExtent: 40,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Provider.of<PrintData>(context, listen: false).updatePaperType(printModel, nomenclatureValues[index]);
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
        ),
      ),
    );
  }
}
