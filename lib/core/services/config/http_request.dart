
import 'package:dio/dio.dart';
import 'config.dart';

class WDXHttpRequest {
  static final BaseOptions baseOptions = BaseOptions(baseUrl: HttpConfig.baseURL, connectTimeout: HttpConfig.timeout);
  final Dio dio = Dio(baseOptions);


  Future<T> request<T>(String url, {
    data, // 数据源
    String method = "get", // 提交方法
    Map<String, dynamic> params, // 另外一种数据
    Map<String, dynamic> headers, // 另外一种数据，比如token
    Interceptor inter, // 自定义拦截器
  }) async{
    // 创建单独配置
    final options = Options(method: method);
    // 发送网络请求

    // 添加拦截器
    if (inter != null) {
      dio.interceptors.addAll([inter]);
    }

    // 添加响应头
    if (headers != null)
      dio.options.headers = headers;
    Response response = await dio.request(url, queryParameters: params, options: options, data: data);
    return response.data;
  }
}