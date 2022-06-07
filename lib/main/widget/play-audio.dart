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
    final ct = InkWell(
      onTap: () {
        print("play");
        audioPlayer!
            .play("http://192.168.101.16:1323/", isLocal: false)
            .then((value) {
          print("play ok");
        }).catchError((onError) {
          print("play error $onError");
        });
      },
      child: Container(
        color: Colors.green,
      ),
    );
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      width: double.infinity,
      child: ct,
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
    audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

    // TODO: implement initState
    super.initState();
  }
}
