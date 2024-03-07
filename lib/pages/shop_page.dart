import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:icon_tile_game/commons/gold_manager.dart';
import '../custom_widget/background_box.dart';
import '../custom_widget/gold_num_button.dart';
import '../custom_widget/key_red_button.dart';
import '../router/router_manager.dart';
import '../commons/db_manager.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  ShopPageState createState() => ShopPageState();
}

const List<String> _kProductIds = <String>['com.gold10'];

const String goldProductId = 'com.gold10';

class ShopPageState extends State<ShopPage> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails>? _products;
  bool _loading = true;

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      // handle error here.
    });
    initStoreInfo();

    super.initState();
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    super.dispose();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      print('无法连接到商店');
      _loading = false;
      return;
    }

    // if (Platform.isIOS) {
    //   final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
    //   _inAppPurchase
    //       .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
    //   await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    // }

    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      print('商品信息查询失败');
      _loading = false;
      return;
    }
    if (productDetailResponse.productDetails.isEmpty) {
      print('无法找到商品信息');
      _loading = false;
      return;
    }

    setState(() {
      _products = productDetailResponse.productDetails;
      _loading = false;
    });
    //先恢复可重复购买
    await _inAppPurchase.restorePurchases();
  }

  /// 购买失败
  void handleError(IAPError? iapError) {
    print("购买失败啦：${iapError?.code} message${iapError?.message}");
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify purchase details before delivering the product.
    if (purchaseDetails.productID == goldProductId) {
      print('购买 10 金币');
    }
  }

  /// 内购的购买更新监听
  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        /// 等待
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            unawaited(deliverProduct(purchaseDetails));
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (Platform.isAndroid) {
          if (purchaseDetails.productID == goldProductId) {
            final InAppPurchaseAndroidPlatformAddition androidAddition =
                _inAppPurchase.getPlatformAddition<
                    InAppPurchaseAndroidPlatformAddition>();
            await androidAddition.consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  // 调用此函数以启动购买过程
  void startPurchase(String productId) async {
    if (_products != null && _products!.isNotEmpty) {
      print("准备开始启动购买流程");
      try {
        ProductDetails productDetails = _getProduct(productId);
        print(
            "一切正常，开始购买,信息如下：title: ${productDetails.title}  desc:${productDetails.description} "
            "price:${productDetails.price}  currencyCode:${productDetails.currencyCode}  currencySymbol:${productDetails.currencySymbol}");

        _inAppPurchase.buyConsumable(
            purchaseParam: PurchaseParam(productDetails: productDetails));
      } catch (e) {
        print("购买失败了");
      }
    } else {
      print("当前没有商品无法调用购买逻辑");
    }
  }

  // 根据产品ID获取产品信息
  ProductDetails _getProduct(String productId) {
    return _products!.firstWhere((product) => product.id == productId);
  }

  logShopping(int goldNum, String amount) async {
    var database = await DBManager().database;
    if (database.isOpen) {
      NewTransactionRecordModel newOne = NewTransactionRecordModel();
      newOne.title = 'Recharge';
      newOne.goodsType = 1;
      newOne.goodsAmount = goldNum;
      newOne.spendType = 0;
      newOne.spendAmount = amount;
      int newId = await DBManager().addOneTransactionRecord(newOne);
      if (newId != 0) {
        print('log success id:$newId');
      }
    }
  }

  buildBackBar() {
    Stack box = Stack(children: [
      const SizedBox(
        height: 34,
        width: double.infinity,
      ),
      SizedBox(
        height: 40,
        width: double.infinity,
        child: GoldNumButton(height: 40.0),
      ),
      const SizedBox(
        width: double.infinity,
        child: Text(
          'Store',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.brown,
              fontSize: 24,
              fontFamily: 'Baloo2',
              fontWeight: FontWeight.w900),
        ),
      ),
      Positioned(
          right: 5,
          child: SizedBox(
              height: 34,
              child: GestureDetector(
                child: const Icon(
                  Icons.cancel_outlined,
                  color: Colors.brown,
                ),
                onTap: () {
                  GlobalPageRouter.back(context);
                },
              )))
    ]);
    return box;
  }

  buildGoodsLine(String goodsId, int goldNum, String price) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white54,
      ),
      height: 70,
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 2,
              child: Image.asset(
                'assets/image/loading_flag.webp',
                fit: BoxFit.contain,
                alignment: Alignment.centerLeft,
              )),
          Expanded(
              flex: 5,
              child: Text(
                goldNum.toString(),
                textAlign: TextAlign.start,
                style: const TextStyle(
                    color: Colors.brown,
                    fontSize: 24,
                    fontFamily: 'Baloo2',
                    fontWeight: FontWeight.w900),
              )),
          Expanded(
            flex: 3,
            child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.lightGreen,
                  ),
                  child: Text(
                    price,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Baloo2',
                        fontWeight: FontWeight.w900),
                  ),
                ),
                onTap: () {
                  GoldManager().buyGold(goldNum);
                  logShopping(goldNum, price);
                }),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundBox(
        image: const AssetImage('assets/image/bg.webp'),
        child: SafeArea(
          child: Column(
            children: [
              buildBackBar(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildGoodsLine(goldProductId, 1000, '\$1.99'),
                    buildGoodsLine(goldProductId, 5000, '\$7.99'),
                    buildGoodsLine(goldProductId, 10000, '\$14.99'),
                    buildGoodsLine(goldProductId, 25000, '\$29.99'),
                    buildGoodsLine(goldProductId, 50000, '\$54.99'),
                    buildGoodsLine(goldProductId, 100000, '\$99.99'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(44, 0, 44, 0),
                child: SizedBox(
                  height: 120,
                  child: Center(
                      child: KeyRedButton(
                    data: "Transaction Records",
                    fontSize: 26,
                    onTap: () {
                      GlobalPageRouter.go(
                          Pages.transactionRecordsPage, context);
                    },
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
