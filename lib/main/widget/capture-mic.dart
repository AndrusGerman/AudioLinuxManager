import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mic_stream/mic_stream.dart';

class CaptureMic extends StatefulWidget {
  CaptureMic({Key? key}) : super(key: key) {}

  @override
  State<CaptureMic> createState() => _CaptureMicState();
}

class _CaptureMicState extends State<CaptureMic> {
  var isRecording = false;
  StreamSubscription<List<int>>? _listener;
  Socket? _socket;

  @override
  Widget build(BuildContext context) {
    final contenButton = Container(
      color: isRecording ? Colors.redAccent : Colors.amber,
      child: Center(
        child: Text(isRecording ? "Recording..." : "Start",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
            )),
      ),
    );

    return InkWell(
      onTap: clickRecording,
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: contenButton,
      ),
    );
  }

  clickRecording() async {
    if (isRecording) {
      _socket!.close();
      _listener!.cancel();
    }
    if (!isRecording) {
      try {
        await startMic();
      } catch (err) {
        print("Err $err");
        return;
      }
    }

    setState(() {
      isRecording = !isRecording;
    });
  }

  startMic() async {
    _socket = await Socket.connect('192.168.101.16', 8080);

    // Init a new Stream
    final stream = await MicStream.microphone(
      audioSource: AudioSource.MIC,
      sampleRate: 41000,
      channelConfig: ChannelConfig.CHANNEL_IN_MONO,
      audioFormat: AudioFormat.ENCODING_PCM_16BIT,
    );

    // Start listening to the stream
    _listener = stream!.listen((samples) {
      _socket!.add(samples);
    });
  }
}
