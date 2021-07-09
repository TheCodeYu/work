import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';

///日志工具
///
///

class LogUtil {
  static late String logPath;

  static File? fileError;
  static File? fileInfo;
  static init() async {
    if (kIsWeb) return;
    logPath = Directory.current.path + '/log';
    String logError;
    String logInfo;
    logError = logPath +
        '/log-error-' +
        DateTime.now().toString().substring(0, 10) +
        '.log';
    logInfo = logPath +
        '/log-info-' +
        DateTime.now().toString().substring(0, 10) +
        '.log';
    if (!(await Directory(logPath).exists())) {
      await Directory(logPath).create();
    }
    if (!(await File(logError).exists())) {
      await File(logError).create();
    }
    fileError = File(logError);
    if (!(await File(logInfo).exists())) {
      await File(logInfo).create();
    }
    fileInfo = File(logInfo);
    await fileError?.writeAsString('Badamon @4mychip.com zhouyu',
        mode: FileMode.append);
    await fileInfo?.writeAsString('Badamon @4mychip.com zhouyu',
        mode: FileMode.append);
  }

  static error(className, msg) async {
    String datetime = DateTime.now().toString();
    log('$datetime  [error] [$className]:' + msg);
    await fileError?.writeAsString('\n$datetime [$className]:' + msg,
        mode: FileMode.append);
  }

  static info(className, msg) async {
    String datetime = DateTime.now().toString();
    log('$datetime  [info] [$className]:' + msg);

    // await fileInfo?.writeAsString('\n$datetime [$className]:' + msg,
    //     mode: FileMode.append);
  }
}
