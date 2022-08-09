import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mic_stream/mic_stream.dart';
import 'package:mutex/mutex.dart';
import 'package:wakelock/wakelock.dart';
import 'capture-mic-input-port.dart';

class CaptureMic extends StatefulWidget {
  const CaptureMic({Key? key}) : super(key: key);

  @override
  State<CaptureMic> createState() => _CaptureMicState();
}

class _CaptureMicState extends State<CaptureMic> {
  var isRecording = false;
  Socket? _socket;
  Mutex mt = Mutex();

  @override
  Widget build(BuildContext context) {
    // status mic
    final status = Text(isRecording ? "Recording..." : "Start",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 40,
        ));
    // List Elements
    final contenButton = Container(
      color: isRecording ? Colors.redAccent : Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [status, CaptureMicInputPort(textController: textController)],
      ),
    );

    return Expanded(
        child: InkWell(
      onTap: clickRecording,
      child: SizedBox(
        width: double.infinity,
        child: contenButton,
      ),
    ));
  }

  clickRecording() async {
    // init recording
    if (!isRecording) {
      try {
        await startMic();
      } catch (err) {
        print("Err $err");
        return;
      }
    }
    // stop recording
    if (isRecording) {
      Wakelock.disable();
      _socket?.close();
      _socket = null;
    }

    setState(() {
      isRecording = !isRecording;
    });
  }

  final TextEditingController textController =
      TextEditingController(text: '192.168.10.109');

  _daemonMic() async {
    // Init a new Stream
    final stream = await MicStream.microphone(
      audioSource: AudioSource.MIC,
      sampleRate: 44100,
      channelConfig: ChannelConfig.CHANNEL_IN_STEREO,
      audioFormat: AudioFormat.ENCODING_PCM_16BIT,
    );

    // Start listening to the stream
    stream?.listen((samples) {
      _socket?.add(samples);
    });
  }

  startMic() async {
    await mt.protect(() async {
      Wakelock.enable();
      if (_socket != null) {
        _socket?.close();
        _socket = null;
      }
      _socket = await Socket.connect(textController.value.text, 8080);
    });
  }

  @override
  void initState() {
    _daemonMic();
    super.initState();
  }
}
