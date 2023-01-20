import 'package:flutter/material.dart';

class DisplayText extends StatelessWidget {
  final String label;
  const DisplayText({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(label);
  }
}
