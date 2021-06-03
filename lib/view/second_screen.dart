import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videolabel/view/image_detail.dart';
import 'package:videolabel/widgets/image_item.dart';
import 'package:videolabel/model/frame_model.dart';
import 'package:videolabel/video_to_frame.dart';

class SecondScreen extends StatefulWidget {
  List<File>? imageList;
  int? index;
  SecondScreen(this.imageList, this.index);
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    FrameModel frameModel = Provider.of<FrameModel>(context, listen: false);
    frameModel.secondImage(widget.imageList, widget.index);

    return Scaffold(
      body: Consumer<FrameModel>(
        builder: (context, frame, child) {
          return GridView.count(
              crossAxisCount: 3,
              children: frameModel.fileList!.isNotEmpty
                  ? frameModel.fileList!
                      .map((image) => GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ImageDetail(image, widget.index!)));
                          },
                          child: ImageItem(file: image)))
                      .toList()
                  : [Container()]);
        },
      ),
    );
  }
}
