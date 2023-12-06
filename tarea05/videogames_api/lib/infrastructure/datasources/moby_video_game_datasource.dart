import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:videogames_api/domain/datasources/video_games_datasource.dart';
import 'package:videogames_api/domain/entities/video_game_info.dart';
import 'package:videogames_api/infrastructure/mappers/video_game_info_mapper.dart';
import 'package:videogames_api/infrastructure/models/moby_games/moby_games_response.dart';

class MobyVideoGameDataSource extends VideogamesDataSource {
  @override
  Future<List<VideoGameInfo>> getAllVideoGames({int limit = 20, int offset = 0}) 
      async {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://api.mobygames.com/v1'
    ));

    final apiKey = dotenv.env['KEY'];

    final response = await dio.get(
      '/games?api_key=$apiKey&limit=$limit&offset=$offset'
    );

    final mobyResponse = MobyGamesResponse.fromJson(response.data).games;

    final List<VideoGameInfo> games = mobyResponse.map(
      (mobyGame) => VideoGameInfoMapper.mobyGameToEntity(mobyGame)
    ).toList();

    return games;
  }
}


// https://api.mobygames.com/v1/games?api_key=moby_vD2YNIYmR0scvVSeWIxtQEQ5lM0&limit=20&offset=0