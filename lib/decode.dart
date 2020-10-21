import 'package:flutter/material.dart';

class DecodeScreen extends StatefulWidget {
  @override
  _DecodeScreenState createState() => _DecodeScreenState();
}

class _DecodeScreenState extends State<DecodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Output",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
