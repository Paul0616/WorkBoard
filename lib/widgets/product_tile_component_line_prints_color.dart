import 'package:flutter/material.dart';
import 'package:work_board/models/prints/print_model.dart';
import 'package:work_board/models/utils/constants.dart';

import 'color_face_rectangle.dart';
import 'icon_face.dart';

class PrintTileComponentLinePrintsColor extends StatelessWidget {
  final List<String> infos;
  final PrintModel printModel;

  PrintTileComponentLinePrintsColor({
    @required this.infos,
    @required this.printModel,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> rowWidgets = [];
    for (String info in infos) {
      rowWidgets.add(Text(
        info,
        style: TextStyle(
          color: Colors.black54,
        ),
      ));
    }

    switch (printModel.colorType) {
      case ColorTypePrints.OneFaceColor:
        {
          rowWidgets.add(ColorFaceRectangle(
            printModel: printModel,
            color: Colors.red,
            firstFace: true,
          ));
          rowWidgets.add(IconFace(
            printModel: printModel,
            faceNumber: 1,
          ));
        }
        break;
      case ColorTypePrints.OneFaceBlackWhite:
        {
          rowWidgets.add(ColorFaceRectangle(
            printModel: printModel,
            color: Colors.black,
            firstFace: true,
          ));
          rowWidgets.add(IconFace(
            printModel: printModel,
            faceNumber: 1,
          ));
        }
        break;
      case ColorTypePrints.TwoFacesBlackWhite:
        {
          rowWidgets.add(ColorFaceRectangle(
            printModel: printModel,
            color: Colors.black,
            firstFace: true,
          ));
          rowWidgets.add(ColorFaceRectangle(
            printModel: printModel,
            color: Colors.black,
            firstFace: false,
          ));
          rowWidgets.add(IconFace(
            printModel: printModel,
            faceNumber: 2,
          ));
        }
        break;
      case ColorTypePrints.TwoFacesColor:
        {
          rowWidgets.add(ColorFaceRectangle(
            printModel: printModel,
            color: Colors.red,
            firstFace: true,
          ));
          rowWidgets.add(ColorFaceRectangle(
            printModel: printModel,
            color: Colors.red,
            firstFace: false,
          ));
          rowWidgets.add(IconFace(
            printModel: printModel,
            faceNumber: 2,
          ));
        }
        break;
      case ColorTypePrints.OneFaceBlackWhiteOneFaceColorWithFirstBlack:
        {
          rowWidgets.add(ColorFaceRectangle(
            printModel: printModel,
            color: Colors.black,
            firstFace: true,
          ));
          rowWidgets.add(ColorFaceRectangle(
            printModel: printModel,
            color: Colors.red,
            firstFace: false,
          ));
          rowWidgets.add(IconFace(
            printModel: printModel,
            faceNumber: 2,
          ));
        }
        break;
      case ColorTypePrints.OneFaceBlackWhiteOneFaceColorWithFirstColor:
        {
          rowWidgets.add(ColorFaceRectangle(
            printModel: printModel,
            color: Colors.red,
            firstFace: true,
          ));
          rowWidgets.add(ColorFaceRectangle(
            printModel: printModel,
            color: Colors.black,
            firstFace: false,
          ));
          rowWidgets.add(IconFace(
            printModel: printModel,
            faceNumber: 2,
          ));
        }
        break;
    }

    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: rowWidgets,
      ),
    );
  }
}