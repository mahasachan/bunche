import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late List<CameraDescription> cameras;
  late CameraController controller;

  FlashMode _flashMode = FlashMode.off;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Camera'),
        ),
        body: FutureBuilder(
          future: _initCamera(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  Expanded(
                    child: CameraPreview(controller),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await controller.setFlashMode(
                            _flashMode == FlashMode.off
                                ? FlashMode.torch
                                : FlashMode.off,
                          );
                          setState(() {
                            _flashMode = _flashMode == FlashMode.off
                                ? FlashMode.torch
                                : FlashMode.off;
                          });
                        },
                        icon: Icon(
                          _flashMode == FlashMode.off
                              ? Icons.flash_off
                              : Icons.flash_on,
                        ),
                      ),
                      IconButton(
                        onPressed: _takePictureWithCamera,
                        icon: const Icon(Icons.camera),
                      ),
                      IconButton(
                        onPressed: getImageFromGallery,
                        icon: const Icon(Icons.image),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _initCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    await controller.initialize();
  }

  Future<void> _next(XFile image) async {
    // final img.Image decodedImage = img.decodeImage(await image.readAsBytes())!;
    Navigator.pop(context, image);
  }

  Future<void> _takePictureWithCamera() async {
    XFile image = await controller.takePicture();
    _next(image);
  }

  Future<void> getImageFromGallery() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    _next(image);
  }
}
