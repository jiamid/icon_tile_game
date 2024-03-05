import 'dart:async';

enum NoticeType {
  /// 刷新金币
  refreshGold,

  /// 随机打乱地图
  randomGameMap,
  /// 回退上一步
  goBackStep,
  /// 重置当前关卡
  resetNowLevel,

}

class NoticeData {
  NoticeData({required this.noticeType, this.data});
  NoticeType noticeType;
  dynamic data;
}

class Notifier {
  static final Notifier _ = Notifier._internal();

  Notifier._internal();

  factory Notifier() {
    return _;
  }

  final StreamController<NoticeData> _controller =
      StreamController<NoticeData>.broadcast();

  Stream<NoticeData> get stream => _controller.stream;

  void send(NoticeType noticeType, {dynamic data}) {
    _controller.add(NoticeData(noticeType: noticeType, data: data));
  }

  void dispose() {
    _controller.close();
  }
}

// bot = Notifier().stream.listen((data) {
// if (data.noticeType == NoticeType.one) {
// do something
// }
// });