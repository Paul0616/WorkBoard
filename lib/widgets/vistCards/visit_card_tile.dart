import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/constants.dart';
import 'package:work_board/models/product_data.dart';
import 'package:work_board/models/visitCard/visit_card_model.dart';
import 'package:work_board/widgets/product_tile_component_line.dart';

class VisitCardTile extends StatelessWidget {
  final VisitCardModel visitCardModel;

  VisitCardTile({this.visitCardModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: <Widget>[
          ProductTileComponentLine(
            infos: [
              'Tiraj ${visitCardModel.quantity.toStringAsFixed(0)} buc',
              '${visitCardModel.value.toStringAsFixed(2)} lei'
            ],
            color: kColorAccent,
            canBeEdited: true,
            canBeDeleted: true,
            model: visitCardModel,
          ),
          ProductTileComponentLine(
            infos: [
              'Imprimare pe 2 fete',
            ],
            canBeEdited: false,
            canBeDeleted: false,
            showCheckedFunction: (checkboxState) {
              Provider.of<ProductData>(context, listen: false)
                  .updateCVProperties(
                      visitCardModel, VisitCardsProperties.bothSides);
            },
            property: VisitCardsProperties.bothSides,
            model: visitCardModel,
          ),
          ProductTileComponentLine(
            infos: [
              'Plastifiere',
            ],
            canBeEdited: false,
            canBeDeleted: false,
            showCheckedFunction: (checkboxState) {
              Provider.of<ProductData>(context, listen: false)
                  .updateCVProperties(
                      visitCardModel, VisitCardsProperties.isPlasticized);
            },
            property: VisitCardsProperties.isPlasticized,
            model: visitCardModel,
          ),
          ProductTileComponentLine(
            infos: [
              'Carton special',
            ],
            canBeEdited: false,
            canBeDeleted: false,
            showCheckedFunction: (checkboxState) {
              Provider.of<ProductData>(context, listen: false)
                  .updateCVProperties(
                      visitCardModel, VisitCardsProperties.isSpecialPaper);
            },
            property: VisitCardsProperties.isSpecialPaper,
            model: visitCardModel,
          ),
        ],
      ),
    );
  }
}
