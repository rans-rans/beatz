import 'package:beatz/src/presentation/controllers/audio_player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';

class SetLoopingButton extends ConsumerStatefulWidget {
  const SetLoopingButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SetLoopingButtonState();
}

class _SetLoopingButtonState extends ConsumerState<SetLoopingButton> {
  final overlayController = OverlayPortalController();
  late ValueNotifier<LoopMode> loopModeNotifier;

  @override
  void initState() {
    super.initState();
    loopModeNotifier =
        ValueNotifier(ref.read(audioPlayerProvider)?.loopMode ?? LoopMode.off);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: OverlayPortal(
        controller: overlayController,
        overlayChildBuilder: (context) {
          return Positioned(
            bottom: 20,
            left: 10,
            child: InkWell(
              onTap: () {
                overlayController.hide();
              },
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Loop modes'),
                    ...LoopMode.values.map((val) {
                      return InkWell(
                        onTap: () {
                          ref.read(audioPlayerProvider)?.setLoopMode(val).then((_) {
                            loopModeNotifier.value = val;
                            overlayController.hide();
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 45,
                          child: Text(
                            val.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
          );
        },
        child: GestureDetector(
          onTap: () {
            overlayController.show();
          },
          child: ValueListenableBuilder(
              valueListenable: loopModeNotifier,
              builder: (context, loopValue, child) {
                return SvgPicture.asset(
                  height: 25,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.color,
                  ),
                  switch (loopValue) {
                    LoopMode.off => 'assets/icons/loop-off.svg',
                    LoopMode.one => 'assets/icons/loop-1.svg',
                    LoopMode.all => 'assets/icons/loop.svg',
                  },
                );
              }),
        ),
      ),
    );
  }
}
