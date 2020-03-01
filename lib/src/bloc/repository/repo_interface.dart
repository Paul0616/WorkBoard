import 'package:work_board/models/utils/prices.dart';

abstract class DataSource{
    Future<Prices> getPrices();
    void dispose();
}