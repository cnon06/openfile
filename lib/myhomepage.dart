import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String fileString = "";
  String fileExtension = "";

  void singleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);

      setState(() {
        fileString = result.files.single.path!.toString();
        fileExtension = result.files.single.extension!.toString();
      });

      
    } else {
      fileString = "User canceled the picker.";
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("File: $fileString, File Extension: $fileExtension"),
            // Image.network(fileString),
            (fileString == "") 
                ? const Text("Select Image")
                : fileExtension == "jpg" || fileExtension == "png" ? Flexible(
                    child: Image.file(
                      File(fileString),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ) 
                  : 
                  const Text("You must select an image of which extension is jpg or png."),
            TextButton(
                onPressed: () {
                  singleFile();
                },
                child: const Text("File")),
          ],
        ),
      ),
    );
  }
}
