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
import 'package:intl/intl.dart' show DateFormat;

class TransactionRecordsPage extends StatefulWidget {
  const TransactionRecordsPage({super.key});

  @override
  TransactionRecordsPageState createState() => TransactionRecordsPageState();
}

class TransactionRecordsPageState extends State<TransactionRecordsPage> {
  List transactionRecordList = [];
  DateFormat dateFormatter = DateFormat('MM/dd/yyyy HH:mm:ss');

  refreshHistoryList() async {
    var database = await DBManager().database;
    if (database.isOpen) {
      transactionRecordList = await DBManager().getAllTransactionRecords();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    refreshHistoryList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Map iconMap = {
    0: const Icon(Icons.attach_money_outlined),
    1: const Icon(Icons.child_care_outlined),
    2: const Icon(Icons.screen_rotation_alt_outlined),
    3: const Icon(Icons.swipe_left_outlined),
    4: const Icon(Icons.settings_backup_restore_outlined),
  };

  _buildTypeIcon(itemType) {
    Widget? thisIcon = iconMap[itemType];
    if (thisIcon != null) {
      return thisIcon;
    }
    return const Icon(Icons.device_unknown);
  }

  _buildTransactionRecordLine(Map data) {
    return Card(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        elevation: 10,
        color: const Color(0xfff3dfad),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    data[TransactionRecordsTableModel.title].toString(),
                    maxLines: 1,
                    style: const TextStyle(
                        fontFamily: 'Baloo2',
                        fontSize: 20,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 2,
                          child: _buildTypeIcon(
                              data[TransactionRecordsTableModel.goodsType])),
                      Expanded(
                        flex: 4,
                        child: Text(
                          data[TransactionRecordsTableModel.goodsAmount]
                              .toString(),
                          maxLines: 1,
                          style: const TextStyle(
                            fontFamily: 'Baloo2',
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: _buildTypeIcon(
                              data[TransactionRecordsTableModel.spendType])),
                      Expanded(
                        flex: 4,
                        child: Text(
                          data[TransactionRecordsTableModel.spendType] == 0
                              ? (data[TransactionRecordsTableModel
                                          .spendAmount] /
                                      100)
                                  .toString()
                              : '-${data[TransactionRecordsTableModel.spendAmount]}',
                          style: const TextStyle(
                            fontFamily: 'Baloo2',
                          ),
                          maxLines: 1,
                        ),
                      )
                    ],
                  )),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    dateFormatter.format(DateTime.fromMillisecondsSinceEpoch(
                        data[TransactionRecordsTableModel.createdAt])),
                    maxLines: 1,
                    style: const TextStyle(
                      fontFamily: 'Baloo2',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
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
                  const Text(
                    'Transaction Records',
                    style: TextStyle(
                        color: Colors.brown,
                        fontSize: 24,
                        fontFamily: 'Baloo2',
                        fontWeight: FontWeight.w900),
                  ),
                  Expanded(
                      child: transactionRecordList.isEmpty
                          ? const Text(
                              'No transaction Records',
                              style: TextStyle(
                                  color: Colors.brown,
                                  fontSize: 24,
                                  fontFamily: 'Baloo2',
                                  fontWeight: FontWeight.normal),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: transactionRecordList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return _buildTransactionRecordLine(
                                    transactionRecordList[index]);
                              }))
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
