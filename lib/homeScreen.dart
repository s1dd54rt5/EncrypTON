import 'dart:convert';
import 'dart:io';
import 'package:EncrypTON/decode.dart';
import 'package:EncrypTON/decodeown.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'globals.dart' as globals;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PlatformFile file;
  String filetext;
  String decodedmessage;
  bool fileUploaded = false;
  Future<String> _read(String path) async {
    String text;
    try {
      final File file = File(path);
      text = await file.readAsString();
    } catch (e) {
      print("Couldn't read file");
    }
    return text;
  }

  List encrypted;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "EncrypTON",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 3 / 100,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 5 / 100),
              child: Text(
                'Encode',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 1 / 100,
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
                  FilePickerResult result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    PlatformFile file = result.files.first;
                    filetext = await _read(file.path);
                    if (filetext != null) {
                      setState(() {
                        fileUploaded = true;
                      });
                    }
                  }
                  // Our message
                  final message = utf8.encode(filetext);

                  // Encrypt
                  encrypted = await globals.cipher.encrypt(
                    message,
                    secretKey: globals.secretKey,
                    nonce: globals.nonce,
                  );

                  print('Encrypted: $encrypted');

                  // Decrypt
                  final decrypted = await globals.cipher.decrypt(
                    encrypted,
                    secretKey: globals.secretKey,
                    nonce: globals.nonce,
                  );
                  decodedmessage = utf8.decode(decrypted);
                  print('Decrypted: $decrypted');
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text(
                    "Upload File",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ),
            ),
            fileUploaded
                ? SizedBox(
                    height: size.height * 2 / 100,
                  )
                : Container(),
            fileUploaded
                ? Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: size.width * 5 / 100),
                    child: Text(
                      'Here is your encoded output',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Container(),
            fileUploaded
                ? SizedBox(
                    height: size.height * 1 / 100,
                  )
                : Container(),
            fileUploaded
                ? Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: size.width * 5 / 100),
                    child: Text(
                      encrypted.toString(),
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  )
                : Container(),
            SizedBox(
              height: size.height * 4 / 100,
            ),
            fileUploaded
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: size.width * 5 / 100),
                        child: Text(
                          'Decode this code',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 1 / 100,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.all(
                            Radius.circular(size.width * 2 / 100),
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal: size.width * 5 / 100),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DecodeScreen(
                                  message: decodedmessage,
                                ),
                              ),
                            );
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
                      SizedBox(
                        height: size.height * 1 / 100,
                      ),
                      Center(
                        child: Text(
                          "--- OR ---",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 1 / 100,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.all(
                            Radius.circular(size.width * 2 / 100),
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal: size.width * 5 / 100),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DecodeOwnScreen(),
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: Text(
                              "Enter my own code",
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
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: size.width * 5 / 100),
                        child: Text(
                          'Decode a message',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 1 / 100,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.all(
                            Radius.circular(size.width * 2 / 100),
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal: size.width * 5 / 100),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DecodeOwnScreen(),
                              ),
                            );
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
            Container(
              height: size.height * 30 / 100,
            )
          ],
        ),
      ),
    );
  }
}
