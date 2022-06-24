import 'package:flutter/material.dart';

class CaptureMicInputPort extends StatelessWidget {
  final TextEditingController textController;
  const CaptureMicInputPort({Key? key, required this.textController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 260,
        height: 70,
        child: TextField(
          controller: textController,
          keyboardType: TextInputType.text,
        ));
  }
}
