import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/models/folders/folder_model.dart';
import 'package:work_board/models/product_data.dart';
import 'package:work_board/models/utils/constants.dart';

import '../product_tile_component_line.dart';

class FolderTile extends StatelessWidget {
  final FolderModel folderModel;

  FolderTile({this.folderModel});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: <Widget>[
            ProductTileComponentLine(
              infos: [
                'Tiraj ${folderModel.quantity.toStringAsFixed(0)} buc',
                '${folderModel.value.toStringAsFixed(2)} lei'
              ],
              color: kColorAccent,
              canBeEdited: true,
              canBeDeleted: true,
              model: folderModel,
            ),
            ProductTileComponentLine(
              infos: [
                'Imprimare pe 2 fete',
              ],
              canBeEdited: false,
              canBeDeleted: false,
              showCheckedFunction: (checkboxState) {
                Provider.of<ProductData>(context, listen: false)
                    .updateFolderProperties(
                        folderModel, FolderProperties.bothSides);
              },
              property: FolderProperties.bothSides,
              model: folderModel,
              description: 'Cost imprimare: ${folderModel.printPrice} lei',
              descriptionCanBeEdited: false,
            ),
            ProductTileComponentLine(
              infos: [
                'Plastifiere',
              ],
              canBeEdited: false,
              canBeDeleted: false,
              showCheckedFunction: (checkboxState) {
                Provider.of<ProductData>(context, listen: false)
                    .updateFolderProperties(
                        folderModel, FolderProperties.isPlasticized);
              },
              property: FolderProperties.isPlasticized,
              model: folderModel,
              description:
                  'Cost plastifiere: ${folderModel.plasticizingPrice} lei',
              descriptionCanBeEdited: false,
            ),
            ProductTileComponentLine(
              infos: [
                'Cotor dublu',
              ],
              canBeEdited: false,
              canBeDeleted: false,
              showCheckedFunction: (checkboxState) {
                Provider.of<ProductData>(context, listen: false)
                    .updateFolderProperties(
                        folderModel, FolderProperties.doubleEdge);
              },
              property: FolderProperties.doubleEdge,
              model: folderModel,
              description: 'Cost biguire: ${folderModel.foldingPrice} lei',
              descriptionCanBeEdited: false,
            ),
            ProductTileComponentLine(
              infos: [
                'Buzunar aplicat',
              ],
              canBeEdited: false,
              canBeDeleted: false,
              showCheckedFunction: (checkboxState) {
                Provider.of<ProductData>(context, listen: false)
                    .updateFolderProperties(
                        folderModel, FolderProperties.havePatchPocket);
              },
              property: FolderProperties.havePatchPocket,
              model: folderModel,
              description: 'Cost buzunare: ${folderModel.pocketsPrice} lei',
              descriptionCanBeEdited: false,
            ),
            ProductTileComponentLine(
              infos: [
                'Mapa',
                '${folderModel.pricePerUnit().toStringAsFixed(2)} lei/buc'
              ],
              canBeEdited: false,
              canBeDeleted: false,
              model: folderModel,
            ),
          ],
        ));
  }
}
