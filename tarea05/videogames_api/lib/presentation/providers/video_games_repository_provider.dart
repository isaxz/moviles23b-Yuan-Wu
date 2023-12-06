import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:videogames_api/infrastructure/datasources/moby_video_game_datasource.dart';
import 'package:videogames_api/infrastructure/repositories/video_games_repository.dart';

final videoGamesRepositoryProvider = Provider(
  (ref) => VideoGamesRepositoryImpl(dataSource: MobyVideoGameDataSource())
);