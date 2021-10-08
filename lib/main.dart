import 'package:flutter/material.dart';
import 'package:right_track/homepage.dart';

void main() => runApp(const RightTrack());

class RightTrack extends StatelessWidget {
  const RightTrack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RightTrack',
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'NotoSansMono'),
      home: const HomePage(title: 'RightTrack'),
    );
  }
}
