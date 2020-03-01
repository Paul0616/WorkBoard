import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:work_board/src/bloc/blocs/product_bloc.dart';
import 'package:work_board/src/bloc/repository/hardcoded_repository.dart';
import 'package:work_board/src/bloc/screens/product_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green,
          textTheme: TextTheme(subhead: TextStyle(color: Colors.black54))),
      debugShowCheckedModeBanner: false,
      home: Provider<ProductBloc>(
        create: (context) => ProductBloc(
          HardcodedPricesRepository(),
        ),
        dispose: (context, bloc) => bloc.dispose(),
        child: ProductScreen(),
      ),
    );
  }
}

