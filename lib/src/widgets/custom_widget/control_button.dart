import 'package:flutter/material.dart';

class ControlButton extends StatefulWidget {
  @override
  _ControlButtonState createState() => _ControlButtonState();
}

class _ControlButtonState extends State<ControlButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _startSection(),
          _purchaseSection(),
          _scoreBoardSection(),
        ],
      ),
    );
  }

  Widget _startSection() {
    return RaisedButton(
      child: Text("Start"),
      onPressed: () {},
      color: Colors.green,
    );
  }

  Widget _purchaseSection() {
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text("Buy"),
          onPressed: () {},
          color: Colors.blueAccent,
        ),
        RaisedButton(
          child: Text("Cell"),
          onPressed: () {},
          color: Colors.redAccent,
        ),
      ],
    );
  }

  Widget _scoreBoardSection() {
    return Column(
      children: <Widget>[
        Text("AI: 123"),
        Text("User: 234"),
      ],
    );
  }
}
