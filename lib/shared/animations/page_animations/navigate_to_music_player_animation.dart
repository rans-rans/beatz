import 'package:beatz/src/features/audio_player/presentation/screens/audio_player_screen.dart';
import 'package:flutter/material.dart';

class NavigateToMusicPlayerAnimation extends PageRouteBuilder {
  NavigateToMusicPlayerAnimation()
      : super(
          transitionDuration: const Duration(milliseconds: 250),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (context, animation, secondaryAnimation) {
            return const AudioPlayerScreen();
          },
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
}
