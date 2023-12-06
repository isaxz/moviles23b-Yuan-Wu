import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:videogames_api/domain/entities/video_game_info.dart';
import 'package:videogames_api/presentation/providers/video_games_repository_provider.dart';

final videoGamesProvider = StateNotifierProvider
  <VideoGamesNotifier, List<VideoGameInfo>>((ref) {
    final fetchVideoGames = ref.watch(videoGamesRepositoryProvider)
      .getAllVideoGames;
    return VideoGamesNotifier(fetchVideoGames: fetchVideoGames);
  }
);

typedef VideoGamesCallback = Future<List<VideoGameInfo>> Function({
  int limit, int offset
});

class VideoGamesNotifier extends StateNotifier<List<VideoGameInfo>> {
  int limit = 20;
  int offset = 0;
  VideoGamesCallback fetchVideoGames;

  VideoGamesNotifier({
    required this.fetchVideoGames
  }) : super([]);

  Future<void> loadVideoGamesInfo() async {
    final List<VideoGameInfo> videoGames = await fetchVideoGames(
      limit: limit, offset: offset
    );
    offset = offset + limit;
    state = [...state, ...videoGames];
  }
}