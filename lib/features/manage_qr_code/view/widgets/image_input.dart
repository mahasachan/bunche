import 'dart:io';
import 'dart:async';

import 'package:bunche/features/manage_qr_code/view/widgets/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});
  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        onPressed: _takePicture,
        icon: const Icon(Icons.camera_alt),
        label: const Text('Take a picture'));

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
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
            onPressed: _pickImage,
            icon: const Icon(Icons.image),
            label: const Text('Pick an image')),
      ],
    );
  }

  Future<void> _takePicture() async {
    // Navigator.pushNamed(context, '/camera');
    final pickedFile = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CameraPage()),
    );
    if (pickedFile == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedFile!.path);
    });
    widget.onPickImage(_selectedImage!);
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedFile.path);
    });
    widget.onPickImage(_selectedImage!);
  }
}
