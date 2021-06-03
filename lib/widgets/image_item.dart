import 'dart:io';

import 'package:flutter/material.dart';

class ImageItem extends StatelessWidget {
  ImageItem({required this.file}) : super(key: ObjectKey(file));
  final File file;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(child: Image.file(file)),
    );
  }
}
