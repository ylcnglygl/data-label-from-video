import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videolabel/model/frame_model.dart';
import 'package:videolabel/video_to_frame.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: FrameModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: VideoToFrames(
          images: <Image>[],
          files: [],
        ),
      ),
    );
  }
}
