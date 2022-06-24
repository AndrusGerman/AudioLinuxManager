import 'package:flutter/material.dart';
//import 'package:audioplayers/audioplayers.dart';
// import 'package:audio_session/audio_session.dart';

// import 'package:just_audio/just_audio.dart';

class PlayAudio extends StatefulWidget {
  const PlayAudio({Key? key}) : super(key: key);

  @override
  State<PlayAudio> createState() => _PlayAudioState();
}

class _PlayAudioState extends State<PlayAudio> {
  //final _player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    final ct = InkWell(
      onTap: () {
        print("Play");
        _init();
      },
      child: Container(
        color: Colors.green,
      ),
    );
    return Expanded(
        child: SizedBox(
      //height: MediaQuery.of(context).size.height / 2,
      width: double.infinity,
      child: ct,
    ));
  }

  Future<void> _init() async {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
}
