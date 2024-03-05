import 'dart:async';
import 'dart:developer';
import '../commons/storage_manager.dart';
import '../commons/notifier_manager.dart';
import 'db_manager.dart';

/// 禁止调整顺序！index为商品类型，新增请从尾部添加
enum GoodsType { cash, gold, randomGameMap, goBackStep, resetNowLevel }

Map<GoodsType, int> goodsPriceMap = {
  GoodsType.randomGameMap: 10,
  GoodsType.goBackStep: 10,
  GoodsType.resetNowLevel: 10,
};

Map<GoodsType, String> goodsTipMap = {
  GoodsType.randomGameMap: 'Rearrange blocks',
  GoodsType.goBackStep: 'Return to the previous step',
  GoodsType.resetNowLevel: 'Restart the current level',
};

Map<GoodsType, NoticeType> goodsNoticeMap = {
  GoodsType.randomGameMap: NoticeType.randomGameMap,
  GoodsType.goBackStep: NoticeType.goBackStep,
  GoodsType.resetNowLevel: NoticeType.resetNowLevel,
};

logSpeedGold(GoodsType goodsType, int goldNum) async {
  var database = await DBManager().database;
  if (database.isOpen) {
    NewTransactionRecordModel newOne = NewTransactionRecordModel();
    newOne.title = 'Purchase Props';
    newOne.goodsType = goodsType.index;
    newOne.goodsAmount = 1;
    newOne.spendType = 1;
    newOne.spendAmount = goldNum;
    int newId = await DBManager().addOneTransactionRecord(newOne);
    if (newId != 0) {
      print('log success id:$newId');
    }
  }
}

class ReduceData {
  ReduceData({required this.goodsType, this.data});

  GoodsType goodsType;
  dynamic data;
}

class GoldManager {
  static final GoldManager _ = GoldManager._internal();

  GoldManager._internal();

  factory GoldManager() {
    return _;
  }

  testReduce(ReduceData data) async {
    int? num = goodsPriceMap[data.goodsType];
    if (num == null) {
      throw Exception('goods type not support');
    }
    int gold = await StorageManager().getValue(StorageKey.gold);
    if (num > gold) {
      log('金币不足');
      return false;
    }
    return true;
  }

  handleReduce(ReduceData data) async {
    bool status = await testReduce(data);
    if (!status) return status;
    int gold = await StorageManager().getValue(StorageKey.gold);
    int price = goodsPriceMap[data.goodsType]!;
    await StorageManager().setValue(StorageKey.gold, gold - price);
    await logSpeedGold(data.goodsType, price);
    Notifier().send(NoticeType.refreshGold);

    NoticeType? noticeType = goodsNoticeMap[data.goodsType];
    if (noticeType != null) {
      Notifier().send(noticeType);
    }
    return true;
  }

  buyGold(int num) async {
    int gold = await StorageManager().getValue(StorageKey.gold);
    await StorageManager().setValue(StorageKey.gold, gold + num);
    Notifier().send(NoticeType.refreshGold);
    return true;
  }
}
