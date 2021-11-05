import 'package:flutter/material.dart';
import 'package:flutter_opinion_monitor/model/home_mo.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoMo videoModel;

  const VideoDetailPage({Key? key, required this.videoModel}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text(widget.videoModel.url ?? ""),
          ],
        ),
      ),
    );
  }
}
