import 'package:dio/dio.dart';

class CountryDioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://restcountries.com/',
        receiveDataWhenStatusError: true,
      ),
    );
  } //end init()

    static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  } //end postUserData()
}
