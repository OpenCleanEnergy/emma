import 'dart:async';
import 'package:chopper/chopper.dart';

class ErrorInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
      Chain<BodyType> chain) async {
    final response = await chain.proceed(chain.request);
    if (response.isSuccessful) {
      return response;
    } else if (response.error is Exception) {
      throw response.error!;
    } else {
      throw ChopperHttpException(response);
    }
  }
}
