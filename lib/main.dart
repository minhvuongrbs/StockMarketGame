import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_market_game/src/widgets/home_screen.dart';
import 'package:stock_market_game/src/widgets/custom_widget/app_state.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
     SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stock Market',
      home: ChangeNotifierProvider<AppState>(
        builder: (_) => AppState(),
        child: HomeScreen(),
        )
      
    );
  }
}

