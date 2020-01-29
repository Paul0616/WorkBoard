import 'package:flutter/material.dart';
import 'package:work_board/constants.dart';
import 'package:work_board/widgets/print_tile_component_line.dart';

class PrintTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: <Widget>[
          PrintTileComponentLine(
            infos: ['Tip hârtie: 80g/mp', '8.00 lei'],
            color: kColor3,
            canBeEdited: false,
            showChecked: false,
          ),
          PrintTileComponentLine(
            infos: [
              'Tiraj: 0',
            ],
            canBeEdited: true,
            showChecked: false,
          ),
          PrintTileComponentLine(
            infos: [
              'Format: A5',
              'L(mm): 148',
              'H(mm): 210',
            ],
            canBeEdited: true,
            showChecked: false,
          ),
          PrintTileComponentLine(
            infos: [
              'Încadrare în A3: 62 buc (8x7)+(6x1)',
            ],
            canBeEdited: false,
            showChecked: false,
            description: 'Încap 56 formate plus 1 fibra inversă',
          ),
          PrintTileComponentLine(
            infos: [
              'Costuri/A4:',
              'Color: 1.54 lei',
              'x 3 A4',
              '= 4.62 lei',
            ],
            canBeEdited: false,
            showChecked: false,
          ),
          PrintTileComponentLine(
            infos: [
              'Costuri/A4:',
              'A/N:   1.54 lei',
              'x 3 A4',
              '= 4.62 lei',
            ],
            canBeEdited: false,
            showChecked: false,
          ),
          PrintTileComponentLine(
            infos: [
              'Adaugă tăieri: 24 tăieri',
            ],
            canBeEdited: true,
            showChecked: true,
          ),
          PrintTileComponentLine1(
            infos: ['Imprimare:'],
            colorType: ColorType.OneFaceBlackWhiteOneFaceColor,
          ),
        ],
      ),
    );
  }
}
