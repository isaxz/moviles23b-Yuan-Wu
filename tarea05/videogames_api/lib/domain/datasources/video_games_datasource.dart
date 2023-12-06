import 'package:videogames_api/domain/entities/video_game_info.dart';

abstract class VideogamesDataSource {
  Future<List<VideoGameInfo>> getAllVideoGames({
    int limit = 20, 
    int offset = 0
  });
}