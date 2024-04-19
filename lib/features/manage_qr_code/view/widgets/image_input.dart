import 'dart:io';
import 'dart:async';

import 'package:bunche/features/manage_qr_code/view/camera.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _imageFile;
  // final _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        onPressed: _takePicture,
        icon: const Icon(Icons.camera_alt),
        label: const Text('Take a picture'));

    if (_imageFile != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _imageFile!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
      ),
      height: 250,
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.all(10),
      alignment: Alignment.center,
      child: content,
    );
  }

  Future<void> _takePicture() async {
    // Navigator.pushNamed(context, '/camera');
    final pickedFile = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CameraPage()),
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile!.path);
      });
    }
  }

  // Future<void> _pickImage() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _imageFile = File(pickedFile.path);
  //     });
  //   }
  // }
}
