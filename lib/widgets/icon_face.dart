import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/models/product_data.dart';
import 'package:work_board/models/prints/print_model.dart';

class IconFace extends StatelessWidget {
  final int faceNumber;
  final PrintModel printModel;
  IconFace({this.printModel, this.faceNumber});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<ProductData>(context, listen: false)
            .updateTwoFaces(printModel);
      },
      child: Image(
        image: AssetImage('images/pag$faceNumber.png'),
      ),
    );
  }
}
