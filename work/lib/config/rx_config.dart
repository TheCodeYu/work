import 'package:work/utils/log_utils.dart';
import 'package:rxdart/rxdart.dart';

/// description:RxDart全局消息封装处理器
///
/// user: yuzhou
/// date: 2021/6/12

class Rx {
  final _subject = PublishSubject<List>();
  Map<String, Map<String, List<Function>>> _signMapping = {};

  Rx() {
    _subject.listen((arg) {
      LogUtil.info(this.runtimeType.toString(), "arg:${arg.toString()}");
      String sign = arg[0];
      var data = arg[1];
      if (_signMapping[sign] != null) {
        _signMapping[sign]!.forEach((key, value) {
          value.forEach((element) {
            element(data);
          });
        });
      }
    });
  }
  void push(String sign, {dynamic data}) {
    _subject.add([sign, data]);
  }

  ///参数[name]为销毁监听标志，当同一个sign被多个模块监听时，销毁方法只会销毁对应name的监听
  ///不传入name会销毁sign的所有注册回调
  void subscribe(String sign, void Function(dynamic data) callback,
      {String name = ''}) {
    if (_signMapping[sign] == null) {
      _signMapping[sign] = {
        name: [callback]
      };
    } else if (_signMapping[sign]![name] == null) {
      _signMapping[sign]![name] = [callback];
    } else {
      _signMapping[sign]![name]!.add(callback);
    }
  }

  void unSubscribe(String sign, {String name = ''}) {
    if (_signMapping[sign] != null &&
        _signMapping[sign]![name] is List<Function>) {
      _signMapping[sign]!.remove(name);
    }
  }
}

final rx = Rx();
