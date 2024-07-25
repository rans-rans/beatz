import 'dart:io';
import 'dart:ui';

import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:beatz/shared/constants/string_constants.dart';
import 'package:beatz/src/presentation/shared/components/add_to_playlist_sheet.dart';
import 'package:beatz/src/presentation/controllers/audio_player_provider.dart';
import 'package:beatz/src/presentation/controllers/audio_view_provider.dart';
import 'package:beatz/src/presentation/screens/music%20player/widgets/audio_slider.dart';
import 'package:beatz/src/presentation/screens/music%20player/widgets/now_playing_buttons.dart';
import 'package:beatz/src/presentation/shared/components/audio_info_sheet.dart';
import 'package:beatz/src/presentation/shared/widgets/now_playing_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioPlayerScreen extends ConsumerStatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends ConsumerState<AudioPlayerScreen>
    with WidgetsBindingObserver {
  String currentAudioPath = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    final audioProvider = ref.read(audioPlayerProvider);
    if (audioProvider?.musicActive == false && audioProvider?.isPlaying == false) {
      Navigator.popUntil(context, ModalRoute.withName('/'));
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(context) {
    final audioPlayerNotifier = ref.watch(audioPlayerProvider.notifier);
    final audioViewNotifier = ref.read(audioViewProvider.notifier);
    return PopScope(
      onPopInvoked: (didPop) async {
        audioViewNotifier.minimizePlayer();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black38,
                          Colors.black38,
                          Colors.black87,
                          Colors.black54,
                        ],
                      ),
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
                //page content
                SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
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
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(
                                  Icons.playlist_add,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  showAddToPlaylistSheet(
                                    context,
                                    audioPlayerNotifier.currentAudioPath,
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  showAudioInfoSheet(
                                    context,
                                    audioPlayerNotifier.currentAudioPath,
                                  );
                                },
                              )
                            ],
                          ),
                          const Spacer(flex: 5),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: switch (picture == null) {
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
                                      height:
                                          MediaQuery.sizeOf(context).height * 0.45,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                            },
                          ),
                          const Spacer(flex: 5),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width * 0.75,
                                    child: const NowPlayingText(fontSize: 16),
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
