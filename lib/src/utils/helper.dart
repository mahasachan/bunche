import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

Future<Uint8List> convertFileToBytes(File file) async {
  Uint8List bytes = await file.readAsBytes();
  return bytes;
}
