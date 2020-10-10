import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as Img;
// import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PhotoHelper {
  // static Future<File> pickImageFromGallery({double maxHeight, double maxWidth}) async {
  //   return ImagePicker.pickImage(source: ImageSource.gallery, maxHeight: maxHeight, maxWidth: maxWidth );
  // }

  // static Future<File> pickImageFromCamera({double maxHeight, double maxWidth}) async {
  //   return ImagePicker.pickImage(source: ImageSource.camera, maxHeight: maxHeight, maxWidth: maxWidth);
  // }

  static Future savePhotoLocal(File imageFile, String name, String version) async {
    var resizedBytes = await compute(_reduceImageSize, imageFile);
    String base64Image = base64Encode(resizedBytes);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(name + version, base64Image);
  }

  static Future savePhotoLocal64(img64, String name, String version) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(name + version, img64);
  }

  static Future<List<int>> _reduceImageSize(File imageToReduce) async {
    final imageBytes = await imageToReduce.readAsBytes();
    final image = Img.decodeImage(imageBytes);
    final resizedImage = Img.copyResize(image, width: 600);
    final resizedImageBytes = Img.encodeJpg(resizedImage, quality: 30);
    return resizedImageBytes;
  }
}