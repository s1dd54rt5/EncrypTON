import 'package:flutter/material.dart';

class DecodeOwnScreen extends StatefulWidget {
  @override
  _DecodeOwnScreenState createState() => _DecodeOwnScreenState();
}

class _DecodeOwnScreenState extends State<DecodeOwnScreen> {
  @override
  List numbers = [];
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Enter list items",
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
              'Enter the items below',
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
              '',
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
