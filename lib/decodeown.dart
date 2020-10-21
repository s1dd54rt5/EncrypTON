import 'dart:convert';

import 'package:EncrypTON/finalScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'globals.dart' as globals;

class DecodeOwnScreen extends StatefulWidget {
  @override
  _DecodeOwnScreenState createState() => _DecodeOwnScreenState();
}

class _DecodeOwnScreenState extends State<DecodeOwnScreen> {
  @override
  List<int> numbers = [
    180,
    165,
    233,
    8,
    161,
    101,
    175,
    119,
    8,
    30,
    118,
    255,
    229,
    134,
    231,
    182,
    246,
    100,
  ];
  List encrypted;
  String currentNumber = '';
  String decodedmessage = '';
  TextEditingController number = TextEditingController();
  bool isEmpty = true;
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
            height: size.height * 6 / 100,
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: false,
              scrollDirection: Axis.horizontal,
              itemCount: numbers.length,
              padding: EdgeInsets.symmetric(horizontal: size.width * 6 / 100),
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 2 / 100,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Theme.of(context).accentColor,
                  ),
                  margin: EdgeInsets.only(
                    right: size.width * 2 / 100,
                  ),
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          numbers[index].toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          FontAwesomeIcons.times,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            numbers.removeAt(index);
                          });
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 100,
          ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 6 / 100,
              right: MediaQuery.of(context).size.width * 6 / 100,
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 1 / 100,
              right: MediaQuery.of(context).size.width * 1 / 100,
              bottom: MediaQuery.of(context).size.height * 0.5 / 100,
              top: MediaQuery.of(context).size.height * 0.1 / 100,
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 6 / 100,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).accentColor),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: TextFormField(
              controller: number,
              onChanged: (value) {
                currentNumber = value;
              },
              cursorColor: Theme.of(context).accentColor,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  FontAwesomeIcons.key,
                  color: Theme.of(context).accentColor,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "Enter a number",
                hintStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 2 / 100,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 3 / 100,
          ),
          Container(
            child: FlatButton(
              onPressed: () {
                setState(() {
                  numbers.add(int.parse(currentNumber));
                  number.clear();
                  print(numbers);
                });
              },
              splashColor: Theme.of(context).accentColor,
              child: Center(
                child: Text(
                  "Add",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 2 / 100,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 2 / 100,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.all(
                Radius.circular(size.width * 2 / 100),
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: size.width * 5 / 100),
            child: FlatButton(
              onPressed: () async {
                encrypted = await globals.cipher.encrypt(
                  numbers,
                  secretKey: globals.secretKey,
                  nonce: globals.nonce,
                );

                // Decrypt
                final decrypted = await globals.cipher.decrypt(
                  encrypted,
                  secretKey: globals.secretKey,
                  nonce: globals.nonce,
                );
                decodedmessage = utf8.decode(decrypted);
                print(decodedmessage);
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => FinalScreen(
                //       message: decodedmessage,
                //     ),
                //   ),
                // );
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  "Decode",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
