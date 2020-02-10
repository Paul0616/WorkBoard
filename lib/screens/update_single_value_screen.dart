import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/models/utils/constants.dart';
import 'package:work_board/models/product_data.dart';

class UpdateSingleValueScreen extends StatelessWidget {
  final String updateText;
  final dynamic model;

  UpdateSingleValueScreen({this.updateText, this.model});

  @override
  Widget build(BuildContext context) {
    String textFieldValue = '0';
    if (updateText == 'Pagini interior')
      textFieldValue = model.insidePageCountMultiple4.toString();
    else
      textFieldValue = model.quantity.toString();

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
                enableInteractiveSelection: false,
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: textFieldValue),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  textFieldValue = value;
                  if (updateText == 'Pagini interior') {
                    try {
                      int multiple4 = int.parse(textFieldValue);
                      Provider.of<ProductData>(context, listen: false)
                          .setShowAlert(model, multiple4 % 4 != 0);

                      //print(model.buttonDisabled);
                    } catch (e) {
                      print(e);
                    }
                  }
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
                disabledColor: kColorTop.withAlpha(50),
                onPressed: () {
                        //addTaskCallback(taskName);
                        if (updateText == 'Pagini interior')
                          Provider.of<ProductData>(context, listen: false)
                              .updatePagInterior(model, textFieldValue);
                        else
                          Provider.of<ProductData>(context, listen: false)
                              .updateQuantity(model, textFieldValue);
                        Navigator.pop(context);
                      },
                child: Text('Modifica'),
                color: kColorTop,
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {

//     set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        Provider.of<ProductData>(context, listen: false)
            .setShowAlert(bookModel, false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
