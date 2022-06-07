import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayAudio extends StatefulWidget {
  const PlayAudio({Key? key}) : super(key: key);

  @override
  State<PlayAudio> createState() => _PlayAudioState();
}

class _PlayAudioState extends State<PlayAudio> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        audioPlayer!.play("http://192.168.101.16:1323/");
      },
      child: Container(
        color: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  AudioPlayer? audioPlayer;

  @override
  void initState() {
    AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
    // TODO: implement initState
    super.initState();
  }
}
