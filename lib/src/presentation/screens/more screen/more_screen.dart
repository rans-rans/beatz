import 'package:beatz/src/presentation/screens/more%20screen/widgets/history_audios_list.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings),
              ),
            ),
            const HistoryAudiosList()
          ],
        ),
      ),
    );
  }
}
