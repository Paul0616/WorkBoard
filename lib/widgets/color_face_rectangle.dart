import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/models/product_data.dart';
import 'package:work_board/models/prints/print_model.dart';

class ColorFaceRectangle extends StatelessWidget {
  final Color color;
  final bool firstFace;
  final PrintModel printModel;
  ColorFaceRectangle({this.color, this.printModel, this.firstFace});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<ProductData>(context, listen: false)
            .updateColorType(printModel, firstFace);
      },
      child: Container(
        width: 30.0,
        height: 30.0,
        color: color,
        child: Center(
            child: Text(
          firstFace ? '1' : '2',
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
