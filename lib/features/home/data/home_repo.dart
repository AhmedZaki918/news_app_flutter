import 'package:news_app/core/network/api_constants.dart';

import '../../../core/network/api_result.dart';
import '../../../core/network/api_service.dart';
import 'model/news_response.dart';

class HomeRepo {
  final ApiService _apiService;

  HomeRepo(this._apiService);

  Future<ApiResult<NewsResponse>> topNews() async {
    try {
      final response = await _apiService.topNews('en',60,ApiConstants.apiKey);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(error.toString());
    }
  }

  Future<ApiResult<NewsResponse>> category(String category) async {
    try {
      final response = await _apiService.category('en',60,category,ApiConstants.apiKey);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(error.toString());
    }
  }
}