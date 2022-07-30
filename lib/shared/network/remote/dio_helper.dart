import 'package:dio/dio.dart';

class DioHelper{
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        connectTimeout: 500 ,
        receiveTimeout: 1000,
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,

      ),
    );
  }
   static Future<Response> getData({
      required String methodUrl,
      required Map<String,dynamic> query,

    })async
    {
     return await dio.get(methodUrl,queryParameters: query);
    }
  }