// ignore_for_file: prefer_final_fields, file_names
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class SoundServices extends ChangeNotifier {
  
  final AudioPlayer audioPlayer = AudioPlayer();
  
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  Duration _duration = Duration.zero;
  Duration get duration => _duration;
  Duration _position = Duration.zero;
  Duration get position => _position;

  void playAudio(String url) async {
    final source = AssetSource(url);
    audioPlayer.play(source);
    _isPlaying = true;

    audioPlayer.onPlayerStateChanged.listen((state) {
      _isPlaying = state == PlayerState.playing;
      notifyListeners();
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      _duration = newDuration;
      notifyListeners();
    });
    audioPlayer.onPositionChanged.listen((newPosition) {
      _position = newPosition;
      notifyListeners();
    });

    notifyListeners();
  }

  void stopAudio() async {
     audioPlayer.stop();
    _isPlaying = false;
    notifyListeners();
  }

  void pauseAudio() {
     audioPlayer.pause();
     _isPlaying = false;
     notifyListeners();
  }

  void seekAudio(Duration position) {
    audioPlayer.seek(position);
    audioPlayer.resume();
  }

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split(".")[0].padLeft(8, "0");
  }
}
