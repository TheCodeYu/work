import 'dart:collection';

import 'package:dio/dio.dart';

/// description:网络请求封装
///
/// user: yuzhou
/// date: 2021/6/20
///[CacheObject] 缓存策略
class CacheObject {
  CacheObject(this.response)
      : timeStamp = DateTime.now().microsecondsSinceEpoch;
  Response response;

  ///缓存创建时间
  int timeStamp;

  @override
  bool operator ==(Object other) {
    return response.hashCode == other.hashCode;
  }

  //将请求uri作为缓存的key
  @override
  int get hashCode => response.realUri.hashCode;
}

///[NetCache] 使用拦截器实现的缓存策略
class NetCache extends Interceptor {
  ///[todo] 暂时存在内存中为确保迭代器顺序和对象插入时间一致顺序一致，我们使用LinkedHashMap
  var cache = LinkedHashMap<String, CacheObject>();

  void delete(String key) {
    cache.remove(key);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // refresh标记是否是"下拉刷新"
    bool refresh = options.extra["refresh"] == true;

    ///如果是下拉刷新，先删除相关缓存
    if (refresh) {
      if (options.extra["list"] == true) {
        ///若是列表，则只要url中包含当前path的缓存全部删除（简单实现，并不精准）
        cache.removeWhere((key, v) => key.contains(options.path));
      } else {
        // 如果不是列表，则只删除uri相同的缓存
        delete(options.uri.toString());
      }
      return handler.next(options);
    }
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == 'get') {
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      var ob = cache[key];
      if (ob != null) {
        ///若缓存未过期，则返回缓存内容
        if ((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) / 1000 <
            10 * 60) {
          return handler.resolve(cache[key]!.response);
        } else {
          ///若已过期则删除缓存，继续向服务器请求
          delete(key);
        }
      }
    }
    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    ///错误状态不缓存
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _saveCache(response);

    handler.next(response);
  }

  _saveCache(Response object) {
    RequestOptions options = object.requestOptions;
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == "get") {
      /// 如果缓存数量超过最大数量限制，则先移除最早的一条记录
      if (cache.length == 100) {
        cache.remove(cache[cache.keys.first]);
      }
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      cache[key] = CacheObject(object);
    }
  }
}

class DioManager {
  static DioManager? _instance;

  static DioManager getInstance() {
    if (_instance == null) _instance = DioManager();
    return _instance!;
  }

  Dio dio = new Dio();

  DioManager() {
    dio.options.baseUrl = ServerUrl.baseUrl;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
    dio.interceptors.add(LogInterceptor(responseBody: true)); //是否开启请求日志
    dio.interceptors.add(NetCache());
    //  dio.interceptors.add(CookieManager(CookieJar()));//缓存相关类，具体设置见https://github.com/flutterchina/cookie_jar
  }
  //get请求
  get(String url, FormData params, Function successCallBack,
      Function errorCallBack) async {
    _requstHttp(url, successCallBack, 'get', params, errorCallBack);
  }

  //post请求
  post(String url, params, Function successCallBack,
      Function errorCallBack) async {
    _requstHttp(url, successCallBack, "post", params, errorCallBack);
  }

  //post请求
  postNoParams(
      String url, Function successCallBack, Function errorCallBack) async {
    _requstHttp(url, successCallBack, "post", null, errorCallBack);
  }

  _requstHttp(String url, Function successCallBack, String method,
      FormData? params, Function errorCallBack) async {
    ///[todo] 增加token处理
    Response response;
    dio.options.headers['Authorization'] = 'getToken()';
    dio.options.headers['Accept'] = 'application/json';
    try {
      if (method == 'get') {
        if (params != null) {
          response = await dio.get(url,
              queryParameters: Map.fromEntries(params.fields));
        } else {
          response = await dio.get(url);
        }
      } else if (method == 'post') {
        if (params != null && params.fields.isNotEmpty) {
          response = await dio.post(url, data: params);
        } else {
          response = await dio.post(url);
        }
      } else {
        print('method error');
        return;
      }
    } on DioError catch (error) {
      // 请求错误处理

      response = error.response ??
          new Response(statusCode: 201, requestOptions: error.requestOptions);

      // debug模式才打印
      if (!bool.fromEnvironment("dart.vm.product")) {
        print('请求异常: ' + error.toString());
      }
      _error(errorCallBack, error.message);
      return '';
    }
    // debug模式打印相关数据
    if (!bool.fromEnvironment("dart.vm.product")) {
      print('请求url: ' + url);
      print('请求头: ' + dio.options.headers.toString());
      if (params != null) {
        print('请求参数: ' + params.toString());
      }

      print('返回参数: ' + response.toString());
    }

    if (response.data == null || response.data['code'] != 200) {
      _error(errorCallBack, response.data['msg'].toString());
    } else
      successCallBack(response.data);
  }

  _error(Function errorCallBack, String error) => errorCallBack(error);
}

class ServerUrl {
  static const baseUrl = 'http://192.168.2.7:8080';
}
