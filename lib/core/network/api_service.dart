import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/home/data/model/news_response.dart';
import 'api_constants.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('everything')
  Future<NewsResponse> search(
    @Query('language') String language,
    @Query('pageSize') int pageSize,
    @Query('q') String keyword,
    @Query('sortBy') String sortBy,
    @Query('apiKey') String apiKey,
  );

  @GET('everything')
  Future<NewsResponse> searchByDomain(
    @Query('language') String language,
    @Query('pageSize') int pageSize,
    @Query('q') String keyword,
    @Query('sortBy') String sortBy,
    @Query('domains') String domains,
    @Query('apiKey') String apiKey,
  );


  @GET('top-headlines')
  Future<NewsResponse> topNews(
      @Query('language') String language,
      @Query('pageSize') int pageSize,
      @Query('apiKey') String apiKey);

  @GET('top-headlines')
  Future<NewsResponse> category(
      @Query('language') String language,
      @Query('pageSize') int pageSize,
      @Query('category') String category,
      @Query('apiKey') String apiKey
      );
}
