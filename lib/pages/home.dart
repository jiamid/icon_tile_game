import 'package:flutter/material.dart';
import 'package:icon_tile_game/commons/global_manager.dart';
import 'package:icon_tile_game/custom_widget/key_red_button.dart';
import '../custom_widget/background_box.dart';
import '../custom_widget/image_icon_button.dart';
import '../custom_widget/key_zoo_board.dart';
import '../router/router_manager.dart';
import '../custom_widget/typing_text.dart';
import '../l10n/app_localizations.dart';

import '../commons/ui_config.dart';
import '../main.dart';
import '../custom_widget/gold_num_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  toggleLang() async {
    GlobalManager()
        .globalKey
        .currentContext
        ?.findAncestorStateOfType<MyAppState>()!
        .toggleLang();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundBox(
        image: const AssetImage('assets/image/bg.webp'),
        child: SafeArea(
          child: Column(
            children: [
              // buildImageButton('assets/image/loading_flag.webp',
              //     onTap: toggleLang),
              SizedBox(
                height: 40,
                child: Padding(
                    // padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(children: [
                      Expanded(
                          child: GoldNumButton(
                        height: 40.0,
                        onTap: () {
                          GlobalPageRouter.go(Pages.shopPage, context);
                        },
                      )),
                      IconButton(
                          onPressed: () {
                            GlobalPageRouter.go(Pages.aboutPage, context);
                          },
                          icon: const Icon(
                            Icons.settings_outlined,
                            size: 30,
                            color: Colors.orangeAccent,
                          )),
                    ])),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 220,
                      child: KeyZooBoard(
                        data: AppLocalizations.of(context)!.tileZoo,
                        fontSize: 64,
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(44, 0, 44, 0),
                    child: SizedBox(
                      height: 120,
                      child: Center(
                          child: KeyRedButton(
                        data: AppLocalizations.of(context)!.playGame,
                        onTap: () {
                          GlobalPageRouter.replace(Pages.gameRoom, context);
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
