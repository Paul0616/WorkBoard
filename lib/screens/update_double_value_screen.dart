import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/models/utils/constants.dart';
import 'package:work_board/models/product_data.dart';


class UpdateDoubleValueScreen extends StatelessWidget {
  final String updateText;
  final dynamic model;
  UpdateDoubleValueScreen({this.updateText, this.model});
  @override
  Widget build(BuildContext context) {
    String textFieldValue1 = model.paperFormat.widthL.toString();
    String textFieldValue2 = model.paperFormat.lengthH.toString();
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
                  color: kColorTop,
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
                      color: kColorTop,
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
                      color: kColorTop,
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
                          model, textFieldValue1, textFieldValue2);
                  Navigator.pop(context);
                },
                child: Text('Add'),
                color: kColorTop,
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
