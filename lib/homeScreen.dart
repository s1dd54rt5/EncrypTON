import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cryptography/cryptography.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PlatformFile file;
  String filetext;
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

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            FilePickerResult result = await FilePicker.platform.pickFiles();

            if (result != null) {
              PlatformFile file = result.files.first;
              filetext = await _read(file.path);
            }
            final cipher = chacha20Poly1305Aead;

            final secretKey = SecretKey.randomBytes(32);

            final nonce = Nonce.randomBytes(12);

            // Our message
            final message = utf8.encode(filetext);

            // Encrypt
            final encrypted = await cipher.encrypt(
              message,
              secretKey: secretKey,
              nonce: nonce,
            );

            print('Encrypted: $encrypted');

            // Decrypt
            final decrypted = await cipher.decrypt(
              encrypted,
              secretKey: secretKey,
              nonce: nonce,
            );
            print(utf8.decode(decrypted));
            print('Decrypted: $decrypted');
          },
          child: Text("Upload File"),
        ),
      ),
    );
  }
}
