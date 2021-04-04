import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MusicWidget extends StatelessWidget {
  static final _assetsAudioPlayer = AssetsAudioPlayer();

  const MusicWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          'assets/music-note.svg',
          height: 100,
          placeholderBuilder: (_) => const CircularProgressIndicator(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.open_in_browser),
              onPressed: () {
                _assetsAudioPlayer.open(Audio('assets/music.mp3'));
              },
            ),
            StreamBuilder<Duration>(
              stream: _assetsAudioPlayer.currentPosition,
              builder: (context, AsyncSnapshot<Duration> asyncSnapshot) {
                if (asyncSnapshot.hasData) {
                  final time = asyncSnapshot.data;
                  if (time != null) {
                    return Text('${time.inMinutes}m ${time.inSeconds}s');
                  } else {
                    return const Text('No time available');
                  }
                }

                return const Text('0m 0s');
              },
            ),
            StreamBuilder(
              stream: _assetsAudioPlayer.isPlaying,
              builder: (context, AsyncSnapshot<bool> isPlaying) {
                if (isPlaying.data ?? false) {
                  return IconButton(
                      icon: const Icon(Icons.pause),
                      onPressed: _assetsAudioPlayer.pause);
                } else {
                  return IconButton(
                      icon: const Icon(Icons.play_arrow),
                      onPressed: _assetsAudioPlayer.play);
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
