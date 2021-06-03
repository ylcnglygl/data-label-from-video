import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:provider/provider.dart';
import 'package:videolabel/model/frame_model.dart';

class ImageDetail extends StatefulWidget {
  final File image;
  int index;
  ImageDetail(this.image, this.index);
  @override
  _ImageDetailState createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  final _imageKey = GlobalKey<ImagePainterState>();
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    FrameModel frameModel = Provider.of<FrameModel>(context, listen: true);
    return Scaffold(
      key: _key,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: ImagePainter.file(
                widget.image,
                key: _imageKey,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                scalable: true,
                colors: [Colors.black, Colors.white],
                brushIcon: const Icon(Icons.brush),
                undoIcon: const Icon(Icons.undo),
                clearAllIcon: const Icon(Icons.clear),
                colorIcon: const Icon(Icons.colorize),
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                  onPressed: () async {
                    frameModel.updateSecondFrameList(
                        _imageKey, widget.image.path);

                    Navigator.pop(context);
                  },
                  child: const Text("Save")),
            )
          ],
        ),
      ),
    );
  }
}
