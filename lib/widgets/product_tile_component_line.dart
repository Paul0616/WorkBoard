import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/models/folders/folder_model.dart';
import 'package:work_board/models/product_data.dart';
import 'package:work_board/models/prints/print_model.dart';
import 'package:work_board/models/visitCard/visit_card_model.dart';
import 'package:work_board/screens/update_double_value_screen.dart';
import 'package:work_board/screens/update_single_value_screen.dart';
import 'package:work_board/widgets/color_face_rectangle.dart';
import 'package:work_board/widgets/icon_face.dart';

import 'package:work_board/models/utils/constants.dart';

class ProductTileComponentLine extends StatelessWidget {
  final List<String> infos;
  final bool firstInfoIsBold;
  final String description;
  final Color color;
  final bool canBeEdited;
  final bool canBeDeleted;
  final bool descriptionCanBeEdited;

  final Function showCheckedFunction;
  final dynamic property;
  final dynamic model;

  ProductTileComponentLine(
      {@required this.infos,
      this.firstInfoIsBold = false,
      this.color,
      @required this.canBeEdited,
      @required this.canBeDeleted,
      this.description,
      this.descriptionCanBeEdited,
      this.showCheckedFunction,
      this.property,
      this.model});

  @override
  Widget build(BuildContext context) {
    List<Widget> rowWidgets = [];
    for (String info in infos) {
      rowWidgets.add(Text(
        info,
        style: TextStyle(
          color: Colors.black54,
          fontWeight: (firstInfoIsBold && info == infos.first)
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ));
      rowWidgets.add(Spacer());
    }
    if (canBeDeleted) {
      rowWidgets.add(Spacer());

      rowWidgets.add(
        GestureDetector(
          onTap: () {
            Provider.of<ProductData>(context, listen: false)
                .deletePrintModel(model);
          },
          child: Icon(
            Icons.delete,
            color: Colors.black54,
          ),
        ),
      );
      rowWidgets.add(SizedBox(
        width: 15.0,
      ));
    }

    bool valueForCheckedFunction = false;
    if (model is PrintModel) valueForCheckedFunction = model.addCut;
    if (model is VisitCardModel) {
      if (property == VisitCardsProperties.bothSides)
        valueForCheckedFunction = model.bothSidePrinted;
      if (property == VisitCardsProperties.isPlasticized)
        valueForCheckedFunction = model.isPlasticized;
      if (property == VisitCardsProperties.isSpecialPaper)
        valueForCheckedFunction = model.isSpecialPaper;
    }
    if (model is FolderModel) {
      if (property == FolderProperties.bothSides)
        valueForCheckedFunction = model.bothSidePrinted;
      if (property == FolderProperties.isPlasticized)
        valueForCheckedFunction = model.isPlasticized;
      if (property == FolderProperties.doubleEdge)
        valueForCheckedFunction = model.doubleEdge;
      if (property == FolderProperties.havePatchPocket)
        valueForCheckedFunction = model.havePatchPocket;
    }

    if (showCheckedFunction != null) {
      rowWidgets.add(
        Checkbox(
          focusColor: kColorTop,
          activeColor: kColorTop,
          value: valueForCheckedFunction,
          onChanged: showCheckedFunction,
        ),
      );
    }

    String rowIdentifier = rowToBeModified(infos[0]);
    if (canBeEdited && rowIdentifier != null) {
      rowWidgets.add(
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: componentToBeEdited(rowIdentifier, model),
                ),
              ),
              isScrollControlled: true,
            );
          },
          child: Icon(
            Icons.arrow_drop_down,
          ),
        ),
      );
    }

    if (canBeEdited && (model is VisitCardModel || model is FolderModel)) {
      rowWidgets.add(
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: UpdateSingleValueScreen(
                    updateText: 'Tiraj',
                    model: model,
                  ),
                ),
              ),
              isScrollControlled: true,
            );
          },
          child: Icon(
            Icons.arrow_drop_down,
          ),
        ),
      );
    }

    List<Widget> columnWidgets = [];
    columnWidgets.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: rowWidgets,
      ),
    );

    if (description != null) {
      List<Widget> descriptionWidgets = [];
      descriptionWidgets.add(
        Text(
          description,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 10,
          ),
        ),
      );
      if (descriptionCanBeEdited) {
        descriptionWidgets.add(
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: UpdateDoubleValueScreen(
                      updateText: 'Dimensiuni:',
                      printModel: model,
                    ),
                  ),
                ),
                isScrollControlled: true,
              );
            },
            child: Text(
              ' (Atinge pentru editare)',
              style: TextStyle(
                color: Colors.red,
                fontSize: 10,
              ),
            ),
          ),
        );
      }

      columnWidgets.add(
        Row(
          children: descriptionWidgets,
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: decorationBox.copyWith(
          color: color != null ? kColorAccent : kColorBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columnWidgets,
      ),
    );
  }
}

class PrintTileComponentLine1 extends StatelessWidget {
  final List<String> infos;
  final PrintModel printModel;

  PrintTileComponentLine1({
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
      case ColorType.OneFaceColor:
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
      case ColorType.OneFaceBlackWhite:
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
      case ColorType.TwoFacesBlackWhite:
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
      case ColorType.TwoFacesColor:
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
      case ColorType.OneFaceBlackWhiteOneFaceColorWithFirstBlack:
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
      case ColorType.OneFaceBlackWhiteOneFaceColorWithFirstColor:
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
