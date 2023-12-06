import 'package:videogames_api/domain/datasources/video_games_datasource.dart';
import 'package:videogames_api/domain/entities/video_game_info.dart';
import 'package:videogames_api/domain/repositories/video_games_repository.dart';

class VideoGamesRepositoryImpl extends VideoGameRepository {

  final VideogamesDataSource dataSource;

  VideoGamesRepositoryImpl({required this.dataSource});

  @override
  Future<List<VideoGameInfo>> getAllVideoGames({
    int limit = 20, 
    int offset = 0
  }) {
    return dataSource.getAllVideoGames(
      limit: limit,
      offset: offset
    );
  }

}