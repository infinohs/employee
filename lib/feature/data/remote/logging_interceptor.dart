import 'package:http_interceptor/http_interceptor.dart';
import 'package:employee/core/app_constant.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print(AppConstant.httpInterceptor + data.toString());
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print(AppConstant.httpInterceptor + data.request!.baseUrl.toString());
    print(AppConstant.httpInterceptor + data.statusCode.toString());
    print(AppConstant.httpInterceptor + data.body.toString());
    return data;
  }
}
