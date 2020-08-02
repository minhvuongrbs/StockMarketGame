import 'package:flutter/material.dart';
import 'package:stock_market_game/src/widgets/custom_widget/control_button.dart';
import 'package:stock_market_game/src/widgets/custom_widget/stock_line_chart.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            StockLineChart(),
            SizedBox(height: 20.0),
            ControlButton(),
          ],
        ),
      ),
    );
  }
}
