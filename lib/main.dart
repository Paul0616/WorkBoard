import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_board/models/print_data.dart';
import 'package:work_board/screens/product_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PrintData(),
        ),
      ],
      child: MaterialApp(
        home: ProductScreen(),
      ),
    ),
  );
}
