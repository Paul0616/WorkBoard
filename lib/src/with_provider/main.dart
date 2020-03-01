import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/models/product_data.dart';
import 'package:work_board/screens/product_screen.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductData(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.green,
            textTheme: TextTheme(subhead: TextStyle(color: Colors.black54))),
        debugShowCheckedModeBanner: false,
        home: ProductScreen(),
      ),
    ),
  );
}