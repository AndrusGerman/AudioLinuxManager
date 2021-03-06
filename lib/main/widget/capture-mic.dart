import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mic_stream/mic_stream.dart';
import 'capture-mic-input-port.dart';

class CaptureMic extends StatefulWidget {
  const CaptureMic({Key? key}) : super(key: key);

  @override
  State<CaptureMic> createState() => _CaptureMicState();
}

class _CaptureMicState extends State<CaptureMic> {
  var isRecording = false;
  StreamSubscription<List<int>>? _listener;
  Socket? _socket;

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

  final TextEditingController textController =
      TextEditingController(text: '192.168.101.16');

  startMic() async {
    print('Host "${textController.value.text}"');
    _socket = await Socket.connect(textController.value.text, 8080);

    // Init a new Stream
    final stream = await MicStream.microphone(
      audioSource: AudioSource.MIC,
      sampleRate: 44100,
      channelConfig: ChannelConfig.CHANNEL_IN_STEREO,
      audioFormat: AudioFormat.ENCODING_PCM_16BIT,
    );

    // Start listening to the stream
    _listener = stream!.listen((samples) {
      _socket!.add(samples);
    });
  }
}
