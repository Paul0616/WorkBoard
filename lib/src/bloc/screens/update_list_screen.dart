import 'package:flutter/material.dart';
import 'package:work_board/models/utils/constants.dart';
import 'package:work_board/src/bloc/widgets/list_with_title.dart';

class UpdateListScreen extends StatelessWidget {
  final String listTitle;
  final dynamic model;
  final List<String> nomenclatureValues;
  final NomenclatureCode code;

  UpdateListScreen(
      {this.nomenclatureValues, this.model, this.listTitle, this.code});

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
          listTitle: listTitle,
          model: model,
          nomenclatureValues: nomenclatureValues,
          code: code,
        ),
      ),
    );
  }
}
