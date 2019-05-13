import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_market_game/src/widgets/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
    );

    return MaterialApp(
      title: 'Stock Market',
      home: HomeScreen(),
      
    );
  }
}

