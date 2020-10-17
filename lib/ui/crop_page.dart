import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_card/services/storage_service.dart';
import 'package:virtual_card/utils/functions.dart';

class CropPage extends StatefulWidget {
  final String version;
  final String imageName;

  CropPage({this.version, this.imageName});

  @override
  _CropPageState createState() => _CropPageState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _CropPageState extends State<CropPage> {
  AppState state;
  File imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    state = AppState.free;
    _pickImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: imageFile != null ? Image.file(imageFile) : Container(child: Text('Upload'),),) ,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildUploadButton(
                "cancelar",
                Icons.cancel,
                close),
            _buildUploadButton(
                "ajustar",
                Icons.crop,
                    () {
                  if (state == AppState.free)
                    _pickImage();
                  else if (state == AppState.picked)
                    _cropImage();
                  else if (state == AppState.cropped) _clearImage();
                }),
            _buildUploadButton(
                "salvar",
                Icons.check,
                    () { saveImage(imageFile);
                         Navigator.pop(context, imageFile.readAsBytesSync());
                       } ),
          ],
        ),
      )
    );
  }

  _buildUploadButton(txt, icon, action) {
    return InkWell(
        onTap: action,
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.012),
          width: MediaQuery.of(context).size.width * 0.18,
          height: MediaQuery.of(context).size.width * 0.14,
          decoration: BoxDecoration(
              color: Colors.black54,
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.04))),
          child: FittedBox(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: Functions.contentButton(txt, icon, Colors.white)),
          ),
        ));
  }

  _pickImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile == null) close();
    else {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        setState(() {
          state = AppState.picked;
        });
      } else close();
    }
  }

  close() {
    Navigator.pop(context, null);
  }

  saveImage(File imageUploaded) {
    StorageService.savePhotoLocal64(imageUploaded, widget.imageName, widget.version);
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          // CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Ajustar imagem',
            toolbarColor: Colors.cyan,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.ratio5x4,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Ajustar imagem',
        ));
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  void _clearImage() {
    imageFile = null;
    setState(() {
      state = AppState.free;
    });
    _pickImage();
  }
}