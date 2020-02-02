import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/constants.dart';
import 'package:work_board/models/product_data.dart';
import 'package:work_board/models/prints/print_model.dart';

class UpdateDoubleValueScreen extends StatelessWidget {
  final String updateText;
  final PrintModel printModel;
  UpdateDoubleValueScreen({this.updateText, this.printModel});
  @override
  Widget build(BuildContext context) {
    String textFieldValue1 = printModel.paperFormat.widthL.toString();
    String textFieldValue2 = printModel.paperFormat.lengthH.toString();
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
          padding: EdgeInsets.symmetric(
            horizontal: 40.0,
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
              TextField(
                autofocus: true,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: TextEditingController(text: textFieldValue1),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  textFieldValue1 = value;
                },
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: kColor2,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: TextEditingController(text: textFieldValue2),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  textFieldValue2 = value;
                },
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: kColor2,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              FlatButton(
                onPressed: () {
                  print('$textFieldValue1 $textFieldValue2');
                  Provider.of<ProductData>(context, listen: false)
                      .updateDimensions(
                          printModel, textFieldValue1, textFieldValue2);
                  Navigator.pop(context);
                },
                child: Text('Add'),
                color: kColor2,
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
