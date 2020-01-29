import 'package:work_board/constants.dart';
import 'package:work_board/models/paper_dimension.dart';
import 'package:work_board/models/product_model.dart';

class PrintModel extends ProductModel {
  PaperType paperType;
  PaperDimensions paperFormat;
  ColorType colorType;
  bool openUpdateScreen;

  PrintModel({this.paperType, this.paperFormat, this.colorType, this.openUpdateScreen = false});

  String getPaperTypeName() {
    return kPaperType[paperType];
  }

  void toggleOpenUpdate() {
    openUpdateScreen = !openUpdateScreen;
  }

  Map<String, String> getA3FitCount(){
    int fitCount = 0;
    int labelWidth = paperFormat.widthL.toInt();
    int labelHeight = paperFormat.lengthH.toInt();

    //WIDTH horizontally on A3 portrait (how many fit on horizontally) exemplu: fitHorizontallyOnA3Portrait=1
    int fitHorizontallyOnA3Portrait = (297 / labelWidth).floor();

    //how much remain horizontally unprinted | exemplu dimRemainOnHorizontallyA3Portrait=87
    int dimRemainOnHorizontallyA3Portrait = 297 % labelWidth;

    //HEIGHT vertically on A3 portrait (how many fit on vertically) exemplu: fitVerticallyOnA3Portrait=5
    int fitVerticallyOnA3Portrait = (420 / labelHeight).floor();

    //how much remain vertically unprinted | exemplu dimRemainOnVerticallyA3Portrait=20
    int dimRemainOnVerticallyA3Portrait = 420 % labelHeight;

    //how many labels fit in total on the A3 portrait exemplu nr1=5x1=5
    int nr1 = fitHorizontallyOnA3Portrait * fitVerticallyOnA3Portrait;

    //HEIGHT horizontally on A3 landscape (how many fit on horizontally) | exemplu: fitHorizontallyOnA3landscape=2
    int fitHorizontallyOnA3landscape = (420 / labelWidth).floor();

    //how much remain horizontally unprinted | exemplu dimRemainOnHorizontallyOnA3Landscape=0
    int dimRemainOnHorizontallyOnA3Landscape = 420 % labelWidth;
    //dimRemainOnHorizontallyOnA3Landscape = dimRemainOnHorizontallyOnA3Landscape.toFixed(2);

    //WIDTH vertically on A3 landscape (how many fit on vertically) | exemplu fitVerticallyOnA3Landscape=3
    int fitVerticallyOnA3Landscape = (297 / labelHeight).floor();

    //how much remain vertically unprinted | exemplu dimRemainVerticallyOnA3Landscape=57
    int dimRemainVerticallyOnA3Landscape = 297 % labelHeight;
    //dimRemainVerticallyOnA3Landscape = dimRemainVerticallyOnA3Landscape.toFixed(2);

    //how many labels fit in total on the A3 landscape | exemplu n2=2x3=6
    int nr2 = fitHorizontallyOnA3landscape * fitVerticallyOnA3Landscape;


    int nrsup1 =(dimRemainOnHorizontallyA3Portrait / labelHeight).floor(); /// exemplu 1
    int nrsup2 = (dimRemainOnVerticallyA3Portrait / labelWidth).floor(); /// exemplu 0
    int nrplus = 0;
    int nrLsup1 = 0;
    int nrHsup1 = 0;
    if(nrsup1 >= nrsup2){
      nrplus = (420 / labelWidth).floor(); /// exemplu 2
      nrLsup1 = nrplus; // 2
      nrHsup1 = nrsup1; // 1
    } else {
      nrplus = (297 / labelHeight).floor(); ////// exemplu  2
      nrLsup1 = nrsup2; // 0
      nrHsup1 = nrplus; // 2
    }


    nrsup1 = (dimRemainOnHorizontallyOnA3Landscape / labelHeight).floor(); //// exemplu 0
    nrsup2 = (dimRemainVerticallyOnA3Landscape / labelWidth).floor(); /// exemplu 0
    int nrLsup2 = 0;
    int nrHsup2 = 0;
    if(nrsup1 >= nrsup2){
      nrplus = (297 / labelWidth).floor(); /// exemplu 1
      nrLsup2 = nrplus; // exemplu 1
      nrHsup2 = nrsup1; // exemplu 0
    } else {
      nrplus = (420 / labelHeight).floor(); /// exemplu 5
      nrLsup2 = nrsup2; // exemplu 0
      nrHsup2 = nrplus; // exemplu 5
    }

    int extraFitCount = 0;
    int extraNrL = 0;
    int extraNrH = 0;
    int nrL = 0;
    int nrH = 0;
    if((nr1 + (nrLsup1*nrHsup1)) > (nr2 + (nrLsup2*nrHsup2))) {
      fitCount = nr1;
      extraFitCount = nrLsup1*nrHsup1;
      extraNrL = nrLsup1;
      extraNrH = nrHsup1;
      nrL = fitHorizontallyOnA3Portrait;
      nrH = fitVerticallyOnA3Portrait;
    }
    if((nr1 + (nrLsup1*nrHsup1)) < (nr2 + (nrLsup2*nrHsup2))) {
      fitCount = nr2;
      extraFitCount = nrLsup2*nrHsup2;
      extraNrL = nrLsup2;
      extraNrH = nrHsup2;
      nrL = fitHorizontallyOnA3landscape;
      nrH = fitVerticallyOnA3Landscape;
    }
    if((nr1 + (nrLsup1*nrHsup1)) == (nr2 + (nrLsup2*nrHsup2))) {
      if (nr1 >= nr2){
        fitCount = nr1;
        extraFitCount = nrLsup1*nrHsup1;
        extraNrL = nrLsup1;
        extraNrH = nrHsup1;
        nrL = fitHorizontallyOnA3Portrait;
        nrH = fitVerticallyOnA3Portrait;
      } else {
        fitCount = nr2;
        extraFitCount = nrLsup2*nrHsup2;
        extraNrL = nrLsup2;
        extraNrH = nrHsup2;
        nrL = fitHorizontallyOnA3landscape;
        nrH = fitVerticallyOnA3Landscape;
      }

    }
    Map<String, String> result = {};
    result['cut'] = extraFitCount != 0 ? '${nrL + nrH + 2 + extraNrL + extraNrH} tăieri': '${nrL + nrH + 2} tăieri';
    result['description'] = extraFitCount != 0 ? '$nrL x $nrH plus $extraNrL x $extraNrH / Încap $fitCount formate plus $extraFitCount fibra inversă' : '$nrL x $nrH';
    if(nrL == 0 || nrH == 0) {
      result['description'] = 'Formatul e mai mare decât A3.';
    }

    fitCount += extraFitCount;
    result['fitCount'] = fitCount.toString();
    return result;
  }

}
