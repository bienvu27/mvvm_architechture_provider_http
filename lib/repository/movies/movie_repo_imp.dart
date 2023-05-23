import 'package:mvvm_architechture_provider_http/models/movies_list/movies_main.dart';

import '../../data/remote/network/api_endpoints.dart';
import '../../data/remote/network/base_api_service.dart';
import '../../data/remote/network/network_appi_service.dart';
import 'movie_repo.dart';

class MovieRepoImp implements MovieRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<MoviesMain?> getMoviesList() async {
    try {
      dynamic response =
          await _apiService.getResponse(ApiEndPoints().getMovies);
      print("MARAJ $response");
      final jsonData = MoviesMain.fromJson(response);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }
}
