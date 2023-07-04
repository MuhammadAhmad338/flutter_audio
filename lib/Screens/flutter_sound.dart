import 'package:flutter/material.dart';
import 'package:my_app/Services/soundServices.dart';
import 'package:provider/provider.dart';

class FlutterSound extends StatefulWidget {
  const FlutterSound({super.key});

  @override
  State<FlutterSound> createState() => _FlutterSoundState();
}

class _FlutterSoundState extends State<FlutterSound> {
  @override
  Widget build(BuildContext context) {
    final soundServices = Provider.of<SoundServices>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Flutter Sound",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blue,
                    child: IconButton(
                        onPressed: () {
                          if (soundServices.isPlaying) {
                            soundServices.pauseAudio();
                          } else {
                            soundServices.playAudio("Beat.mp3");
                          }
                        },
                        icon: Icon(
                          soundServices.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                        ))),
                const SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  radius: 25,
                  child: IconButton(
                    icon: const Icon(Icons.stop),
                    onPressed: () {
                      soundServices.stopAudio();
                    },
                  ),
                ),
              ],
            ),
            Slider(
                activeColor: Colors.blue,
                min: 0,
                value: soundServices.position.inSeconds.toDouble(),
                max: soundServices.duration.inSeconds.toDouble(),
                onChanged: (value) {
                  final position = Duration(seconds: value.toInt());
                  soundServices.seekAudio(position);
                }),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(soundServices
                      .formatTime(soundServices.position.inSeconds)),
                  Text(soundServices.formatTime(
                      (soundServices.duration - soundServices.position)
                          .inSeconds))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
