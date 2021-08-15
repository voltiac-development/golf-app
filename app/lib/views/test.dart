import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:golfcaddie/components/appbar.dart';
import 'package:golfcaddie/env.dart';
import 'package:golfcaddie/vendor/storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class TestView extends StatefulWidget {
  TestView({Key? key}) : super(key: key);

  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'DEBUG', person: true, back: true),
      body: Row(
        children: <Widget>[
          IconButton(onPressed: () => _pickImage(ImageSource.camera), icon: Icon(Icons.camera)),
          IconButton(onPressed: () => _pickImage(ImageSource.gallery), icon: Icon(Icons.picture_as_pdf)),
          IconButton(onPressed: () => Storage().delItem('jwt'), icon: Icon(Icons.logout_outlined)),
        ],
      ),
    );
  }

  XFile? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    XFile? selected = await new ImagePicker().pickImage(source: source);
    Dio dio = await AppUtils.getDio();
    MultipartFile formD = await MultipartFile.fromFile(selected!.path, filename: selected.name);
    try {
      FormData fData = new FormData.fromMap({"file": formD});
      dio.post('/test', data: fData).then((value) => print(value));
    } catch (e) {
      print(e);
    }
    setState(() {
      print('defhasjkdfkasjdf');
      selected.length().then((value) => print(value));
      _imageFile = selected;
    });
  }

  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  Future<void> _cropImage() async {
    File? cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile!.path,
    );
    setState(() {
      print(cropped);
      _imageFile = cropped as XFile? ?? _imageFile;
    });
  }
}

class ImageCapture extends StatefulWidget {
  ImageCapture({Key? key}) : super(key: key);

  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await new ImagePicker().pickImage(source: source) as File;
    setState(() {
      _imageFile = selected;
    });
  }

  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  Future<void> _cropImage() async {
    File? cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile!.path,
    );
    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
