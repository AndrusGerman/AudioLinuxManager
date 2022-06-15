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
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      width: double.infinity,
      child: ct,
    );
  }

  Future<void> _init() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    // final session = await AudioSession.instance;
    // await session.configure(const AudioSessionConfiguration.speech());
    // // Listen to errors during playback.
    // _player.playbackEventStream.listen((event) {},
    //     onError: (Object e, StackTrace stackTrace) {
    //   print('A stream error occurred: $e');
    // });
    // // Try to load audio from a source and catch any errors.
    // try {
    //   // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
    //   await _player.setAudioSource(
    //       AudioSource.uri(Uri.parse("http://192.168.101.16:1323/file.wav")));
    // } catch (e) {
    //   print("Error loading audio source: $e");
    // }
  }

  @override
  void dispose() {
    //_player.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}
