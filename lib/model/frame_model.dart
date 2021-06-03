import 'dart:io';
import 'dart:typed_data';

import 'package:export_video_frame/export_video_frame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:image_painter/image_painter.dart';
import 'package:image_picker/image_picker.dart';

class FrameModel extends ChangeNotifier {
  List<File>? fileList;
  int? pageIndex;

  void secondImage(List<File>? imageList, int? index) {
    pageIndex = index;
    List<File> imageListSecond;
    imageListSecond = List.of(imageList!);

    fileList =
        imageListSecond.getRange((index!) * 24, (24 + index * 24)).toList();
    notifyListeners();
  }

  void updateSecondFrameList(
      GlobalKey<ImagePainterState> imageKey, String path) async {
    Uint8List byteArray = await imageKey.currentState!.exportImage();
    File imgFile = File(path);
    imgFile.writeAsBytesSync(byteArray);
    notifyListeners();
  }
}
