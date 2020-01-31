import 'package:flutter/material.dart';
import 'package:work_board/models/print_model.dart';
import 'package:work_board/widgets/list_with_title.dart';
import 'package:work_board/constants.dart';

class UpdateListScreen extends StatelessWidget {
  final String updateText;
  final PrintModel printModel;
  final List<String> nomenclatureValues;
  final NomenclatureCode code;

  UpdateListScreen(
      {this.nomenclatureValues, this.printModel, this.updateText, this.code});

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
        child: ListWithTitle(
          updateText: updateText,
          printModel: printModel,
          nomenclatureValues: nomenclatureValues,
          code: code,
        ),
      ),
    );
  }
}
