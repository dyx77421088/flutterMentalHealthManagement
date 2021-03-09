import 'package:date_format/date_format.dart';

class WDXTime {
  /// 获得当前的日期
  static String getNowDate({int timeStamp}) {
    return formatDate(DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000), [yyyy, '-', mm, '-', dd]);
  }

  /// 传递时间需要的格式
  static String toTime({int timeStamp}) {
    return formatDate(DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000), [yyyy, '-', mm, '-', dd, 'T', HH, ":", nn]);
  }
}