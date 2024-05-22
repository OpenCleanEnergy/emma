import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:logging/logging.dart';

class LoggingInterceptor implements Interceptor {
  LoggingInterceptor({required Logger logger}) : _logger = logger;

  final Logger _logger;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
      Chain<BodyType> chain) async {
    final request = chain.request;
    await _logRequest(request);

    final Stopwatch stopWatch = Stopwatch()..start();
    final response = await chain.proceed(request);
    _logResponse(response, stopWatch.elapsed);

    return response;
  }

  Future<void> _logRequest(Request request) async {
    final base = await request.toBaseRequest();
    final startRequestMessage = '--> ${base.method} ${base.url.toString()}';
    _logger.info(ChopperLogRecord(startRequestMessage, request: request));
  }

  void _logResponse(Response response, Duration elapsed) {
    final base = response.base;

    var reasonPhrase = response.statusCode.toString();
    if (base.reasonPhrase != null && base.reasonPhrase != reasonPhrase) {
      reasonPhrase += ' ${base.reasonPhrase}';
    }

    _logger.info(ChopperLogRecord(
      '<-- ${base.request?.method} ${base.request?.url.toString()} | $reasonPhrase | ${elapsed.inMilliseconds}ms',
      response: response,
    ));
  }
}
