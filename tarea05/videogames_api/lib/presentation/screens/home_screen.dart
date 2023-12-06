import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:videogames_api/presentation/providers/video_games_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Videogames!'),
      ),
      body: const _Homeview(),
    );
  }
}

class _Homeview extends ConsumerStatefulWidget {
  const _Homeview();

  @override
  _HomeviewState createState() => _HomeviewState();
}

class _HomeviewState extends ConsumerState<_Homeview> {
  
  @override
  void initState() {
    super.initState();
    ref.read(videoGamesProvider.notifier).loadVideoGamesInfo();
  }

  @override
  Widget build(BuildContext context) {
    final videoGamesInfo = ref.watch(videoGamesProvider);
    return ListView.builder(
      itemCount: videoGamesInfo.length,
      itemBuilder: (context, index) {
        final videoGame = videoGamesInfo[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListBody(
            children: [
              Row(
                children: [
                  Image.network(
                    videoGame.sampleCover.thumbnailImage,
                    width: 100,
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: Text(videoGame.title),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
            ]
          ),
        );
      },
    );
  }
}