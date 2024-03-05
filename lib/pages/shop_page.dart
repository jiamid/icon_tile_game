import 'package:flutter/material.dart';
import 'package:icon_tile_game/commons/gold_manager.dart';
import '../custom_widget/background_box.dart';
import '../custom_widget/gold_num_button.dart';
import '../custom_widget/image_icon_button.dart';
import '../custom_widget/key_red_button.dart';
import '../custom_widget/key_zoo_board.dart';
import '../router/router_manager.dart';
import '/custom_widget/typing_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../commons/db_manager.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  ShopPageState createState() => ShopPageState();
}

class ShopPageState extends State<ShopPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  logShopping(int goldNum, int amount) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundBox(
        image: const AssetImage('assets/image/bg.webp'),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 40,
                width: double.infinity,
                child: GoldNumButton(height: 40.0),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(44, 0, 44, 0),
                    child: SizedBox(
                      height: 120,
                      child: Center(
                          child: KeyRedButton(
                        data: "Buy 10 Gold",
                        onTap: () {
                          GoldManager().buyGold(10);
                          logShopping(10, 199);
                        },
                      )),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(44, 0, 44, 0),
                    child: SizedBox(
                      height: 120,
                      child: Center(
                          child: KeyRedButton(
                        data: "Back",
                        onTap: () {
                          GlobalPageRouter.back(context);
                        },
                      )),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
