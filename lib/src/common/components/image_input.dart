import 'dart:io';
// import 'dart:async';

// import 'package:bunche/src/common/components/camera.dart';
import 'package:bunche/src/utils/camera/image_input_manager.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});
  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  ImageInputManager imageInputManager = ImageInputManager();
  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        //onPressed: _takePicture,
        onPressed: () async {
          await imageInputManager.takePicture(context);
          widget.onPickImage(imageInputManager.selectedImage!);
          setState(() {
            _selectedImage = File(imageInputManager.selectedImage!.path);
          });
        },
        icon: const Icon(Icons.camera_alt),
        label: const Text('Take a picture'));

    if (_selectedImage != null) {
      content = GestureDetector(
        // onTap: _takePicture,
        onTap: () async {
          await imageInputManager.takePicture(context);
          setPicture();
        },

        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black),
          ),
          height: 250,
          width: MediaQuery.of(context).size.width * 0.8,
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: content,
        ),
        ElevatedButton.icon(
            // onPressed: _pickImage,
            onPressed: () async {
              await imageInputManager.pickImage();
              setPicture();
            },
            icon: const Icon(Icons.image),
            label: const Text('Pick an image')),
      ],
    );
  }

  Future<void> setPicture() async {
    if (imageInputManager.selectedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(imageInputManager.selectedImage!.path);
    });
    widget.onPickImage(imageInputManager.selectedImage!);
  }
}
