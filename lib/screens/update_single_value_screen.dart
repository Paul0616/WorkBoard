import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/constants.dart';
import 'package:work_board/models/product_data.dart';
import 'package:work_board/models/prints/print_model.dart';

class UpdateSingleValueScreen extends StatelessWidget {
  final String updateText;
  final PrintModel printModel;
  UpdateSingleValueScreen({this.updateText, this.printModel});
  @override
  Widget build(BuildContext context) {
    String textFieldValue = printModel.quantity.toString();
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
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: textFieldValue),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  textFieldValue = value;
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
                  //addTaskCallback(taskName);
                  Provider.of<ProductData>(context, listen: false)
                      .updateQuantity(printModel, textFieldValue);
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
