import 'package:news_app/core/network/api_constants.dart';

import '../../../core/network/api_result.dart';
import '../../../core/network/api_service.dart';
import '../../home/data/model/news_response.dart';

class SearchRepo {
  final ApiService _apiService;

  SearchRepo(this._apiService);

  Future<ApiResult<NewsResponse>> search(
    String keyword,
    String sortBy,
  ) async {
    try {
      final response = await _apiService.search(
        'en',
        60,
        keyword,
        sortBy,
        ApiConstants.apiKey,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(error.toString());
    }
  }

  Future<ApiResult<NewsResponse>> searchByDomain(
    String keyword,
    String sortBy,
    String domains,
  ) async {
    try {
      final response = await _apiService.searchByDomain(
        'en',
        60,
        keyword,
        sortBy,
        domains,
        ApiConstants.apiKey
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(error.toString());
    }
  }
}
