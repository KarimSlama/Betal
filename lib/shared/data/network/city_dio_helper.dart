import 'package:dio/dio.dart';

class CityDioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.api-ninjas.com/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'X-Api-Key': '/zQ3ivGoKABhTnLC69AjFA==9nAT1FPNO8Gd3GkQ',
    };
    return await dio!.get(url, queryParameters: query);
  }
}
