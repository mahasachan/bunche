import 'dart:io';

import 'package:bunche/src/modules/camera/camera.dart';
import 'package:bunche/src/utils/navigate/navigator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInputManager {
  NavigationService navigationService = NavigationService();

  File? selectedImage;
  Future<void> takePicture(BuildContext context) async {
    final pickedFile = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CameraPage()),
    );

    if (pickedFile == null) {
      return;
    }
    selectedImage = File(pickedFile!.path);
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }

    selectedImage = File(pickedFile.path);
  }
}
