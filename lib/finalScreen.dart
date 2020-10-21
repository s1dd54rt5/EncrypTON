import 'package:flutter/material.dart';

class FinalScreen extends StatefulWidget {
  @override
  final String message;
  _FinalScreenState createState() => _FinalScreenState();
  FinalScreen({@required this.message});
}

class _FinalScreenState extends State<FinalScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 2 / 100,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 5 / 100),
            child: Text(
              'Here is your decoded output',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 1 / 100,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 5 / 100),
            child: Text(
              widget.message,
              style: TextStyle(
                color: Colors.pink,
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
