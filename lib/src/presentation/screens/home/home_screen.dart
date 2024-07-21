import 'package:beatz/shared/helpers/intent_helpers.dart';
import 'package:beatz/src/presentation/controllers/audio_player_provider.dart';
import 'package:beatz/src/presentation/screens/folder%20screen/folder_screen.dart';
import 'package:beatz/src/presentation/screens/library/library_screen.dart';
import 'package:beatz/src/presentation/screens/more%20screen/more_screen.dart';
import 'package:beatz/src/presentation/widgets/minimized_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with WidgetsBindingObserver {
  int currentBottomNavIndex = 0;
  bool addBottomSpacing = false;

  final navigationPages = const [
    LibraryScreen(),
    FolderScreen(),
    MoreScreen(),
  ];

  Future<void> requestFolderPermission() async {
    await Future.wait([
      Permission.mediaLibrary.request(),
      Permission.manageExternalStorage.request(),
    ]);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    final audioAvailable = ref.read(audioPlayerProvider) != null;
    if (state == AppLifecycleState.resumed && audioAvailable) {
      Navigator.popUntil(context, ModalRoute.withName('/'));
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: ReceiveSharingIntent.instance.getMediaStream(),
          builder: (context, snapshot) {
            final data = snapshot.data?.map((data) => data.path).toList() ?? [];
            initializeIntentAudioFiles(ref, data, context);
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                FutureBuilder(
                  future: requestFolderPermission(),
                  builder: (context, snapshot) {
                    return IndexedStack(
                      index: currentBottomNavIndex,
                      children: navigationPages,
                    );
                  },
                ),
                const MinimizedPlayer()
              ],
            );
          }),
      bottomNavigationBar: NavigationBar(
        height: kBottomNavigationBarHeight * 1.5,
        selectedIndex: currentBottomNavIndex,
        onDestinationSelected: (value) {
          currentBottomNavIndex = value;
          setState(() {});
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.library_music),
            label: "Library",
          ),
          NavigationDestination(
            icon: Icon(Icons.folder),
            label: "Folder",
          ),
          NavigationDestination(
            icon: Icon(Icons.more_horiz),
            label: "More",
          ),
        ],
      ),
    );
  }
}
