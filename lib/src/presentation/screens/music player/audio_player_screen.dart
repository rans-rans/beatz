import 'dart:io';
import 'dart:ui';

import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:beatz/shared/constants/string_constants.dart';
import 'package:beatz/src/presentation/controllers/audio_player_provider.dart';
import 'package:beatz/src/presentation/controllers/audio_view_provider.dart';
import 'package:beatz/src/presentation/screens/music%20player/widgets/audio_slider.dart';
import 'package:beatz/src/presentation/screens/music%20player/widgets/now_playing_buttons.dart';
import 'package:beatz/src/presentation/widgets/now_playing_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioPlayerScreen extends ConsumerWidget {
  const AudioPlayerScreen({super.key});
  @override
  Widget build(context, ref) {
    final audioPlayerNotifier = ref.watch(audioPlayerProvider.notifier);
    final audioViewNotifier = ref.read(audioViewProvider.notifier);
    return PopScope(
      onPopInvoked: (didPop) async {
        audioViewNotifier.minimizePlayer();
      },
      child: Scaffold(
        body: FutureBuilder(
          future: readMetadata(
            File(audioPlayerNotifier.currentAudioPath),
            getImage: true,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final picture = snapshot.data?.pictures.firstOrNull?.bytes;
            return Stack(
              children: [
                //blurred background image
                ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    height: MediaQuery.sizeOf(context).height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        image: picture == null
                            ? const AssetImage(placeholderImagePath)
                            : MemoryImage(picture),
                      ),
                    ),
                  ),
                ),
                //page content with black gradient overlay
                Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.black54,
                        Colors.black54,
                        Colors.black38,
                        Colors.black45,
                        Colors.black87,
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton.outlined(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                          const Spacer(flex: 5),
                          switch (picture == null) {
                            true => Image.asset(
                                placeholderImagePath,
                                width: double.infinity,
                                height: MediaQuery.sizeOf(context).height * 0.45,
                                fit: BoxFit.cover,
                              ),
                            false => Image.memory(
                                picture!,
                                fit: BoxFit.cover,
                                height: MediaQuery.sizeOf(context).height * 0.45,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    placeholderImagePath,
                                    width: double.infinity,
                                    height: MediaQuery.sizeOf(context).height * 0.45,
                                    fit: BoxFit.cover,
                                  );
                                },
                              )
                          },
                          const Spacer(flex: 5),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width * 0.75,
                                    child: const NowPlayingText(
                                      fontSize: 16,
                                      fontColor: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      //TODO implement add to favorite
                                    },
                                  ),
                                ],
                              ),
                              const AudioSlider(),
                              const NowPlayingButtons()
                            ],
                          ),
                          const Spacer(flex: 1)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
