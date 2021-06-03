import 'dart:io';
import 'package:flutter/material.dart';
import 'package:videolabel/view/second_screen.dart';

class FramePerSecond extends StatefulWidget {
  List<File> images;
  int duration;
  FramePerSecond(this.images, this.duration);
  @override
  _FramePerSecondState createState() => _FramePerSecondState();
}

class _FramePerSecondState extends State<FramePerSecond> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: widget.duration,
            itemBuilder: (context, index) {
              return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SecondScreen(widget.images, index)));
                  },
                  child: Text("second${index + 1}"));
            }));
  }
}
