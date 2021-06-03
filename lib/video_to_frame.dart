import 'dart:async';
import 'dart:io';
import 'package:export_video_frame/export_video_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:flutter_ffmpeg/stream_information.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:videolabel/constant.dart';
import 'package:videolabel/frame_per_second.dart';
import 'package:videolabel/widgets/beautiful_button.dart';
import 'package:videolabel/widgets/lottie_widget.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:flutter/services.dart' show rootBundle;

class VideoToFrames extends StatefulWidget {
  VideoToFrames({Key? key, required this.images, required this.files})
      : super(key: key);

  final List<Image> images;
  final List<File> files;

  @override
  _VideoToFramesState createState() => _VideoToFramesState();
}

class _VideoToFramesState extends State<VideoToFrames> {
  var _isClean = false;
  var _isLoading = false;
  var _isStart = false;
  Timer? _timer;
  String? frames;
  List<String> framesList = [];
  String? duration;
  final _picker = ImagePicker();
  var i = 0;
  VideoPlayerController? videoPlayerController;
  final videoInfo = FlutterVideoInfo();
  int? fps;

  Future _getImages() async {
    PickedFile? file = await _picker.getVideo(source: ImageSource.gallery);

    final FlutterFFprobe _flutterFFprobe = new FlutterFFprobe();

    _flutterFFprobe.getMediaInformation(file!.path).then((ffinfo) {
      List<StreamInformation>? streams = ffinfo.getStreams();

      setState(() {
        duration = ffinfo.getMediaProperties()!['duration'];
        duration = duration!.substring(0, 2);
        frames = streams![1].getAllProperties()['nb_frames'];

        _isLoading = true;
        _isStart = true;
      });
    });

    var imagesFile = await ExportVideoFrame.exportImage(file.path, 265, 10.0);

    setState(() {
      widget.files.addAll(imagesFile);
      _isLoading = false;
    });

    print("Done");
    print(int.parse(duration!));
    print(int.parse(frames!));
  }

  void _deleteDirectory() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    appDocDirectory.delete(recursive: true);
    ExportVideoFrame.cleanImageCache();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? buildLottieWidget()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _getImages();
                  },
                  child:
                      BeautifulButton("Convert Video", Colors.red, Colors.pink),
                ),
                SizedBox(height: 10),
                Visibility(
                  visible: _isStart,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FramePerSecond(
                                  widget.files, int.parse(duration!))));
                    },
                    child: BeautifulButton(
                        "Frame Screen", Colors.blue, Colors.green),
                  ),
                )
              ],
            ),
    );
  }
}

Widget buildLottieWidget() {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    LottieCustomWidget(path: AppConstant.VIDEO_LOTTIE),
    Text(
      "Video is dividing into frames..",
      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    )
  ]);
}
