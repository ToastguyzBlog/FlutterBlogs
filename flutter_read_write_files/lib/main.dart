import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Blog Posts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  readFilesFromAssets() async {
    // Users can load any kind of files like txt, doc or json files as well
    String assetContent = await rootBundle.loadString('assets/Toastguyz.txt');

    print("assetContent : ${assetContent}");
  }

  readFilesFromCustomDevicePath() async {
    // Retrieve "External Storage Directory" for Android and "NSApplicationSupportDirectory" for iOS
    Directory directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();

    // Create a new file. You can create any kind of file like txt, doc , json etc.
    File file = await File("${directory.path}/Toastguyz.json").create();

    // Read the file content
    String fileContent = await file.readAsString();
    print("fileContent : ${fileContent}");
  }

  writeFilesToCustomDevicePath() async {
    // Retrieve "External Storage Directory" for Android and "NSApplicationSupportDirectory" for iOS
    Directory directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();

    // Create a new file. You can create any kind of file like txt, doc , json etc.
    File file = await File("${directory.path}/Toastguyz.json").create();

    // You can write to file using writeAsString. This method takes string argument
    // To write to text file we can use like file.writeAsString("Toastguyz file content");
    return await file.writeAsString(json.encode({
      "Website": {
        "Name": "Toastguyz",
        "Description": "Programming Tutorials",
      },
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Read & Write Files")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              color: Colors.blueAccent,
              onPressed: () {
                readFilesFromAssets();
              },
              child: Text(
                "Read files from assets",
                style: TextStyle(color: Colors.white),
              ),
            ),
            RaisedButton(
              color: Colors.blueAccent,
              onPressed: () {
                readFilesFromCustomDevicePath();
              },
              child: Text(
                "Read files from custom device path",
                style: TextStyle(color: Colors.white),
              ),
            ),
            RaisedButton(
              color: Colors.blueAccent,
              onPressed: () {
                writeFilesToCustomDevicePath();
              },
              child: Text(
                "Write files to custom device path",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
