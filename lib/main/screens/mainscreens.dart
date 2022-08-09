import 'package:flutter/material.dart';
import 'package:mic_linux/main/widget/capture-mic.dart';
import 'package:mic_linux/main/widget/play-audio.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: const [
        CaptureMic(),
        PlayAudio(),
      ],
    ));
  }
}
