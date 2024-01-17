import 'package:flutter/material.dart';
import 'package:icon_tile_game/commons/global_manager.dart';
import 'package:icon_tile_game/custom_widget/key_red_button.dart';
import '../custom_widget/background_box.dart';
import '../custom_widget/key_zoo_board.dart';
import '../router/router_manager.dart';
import '../custom_widget/typing_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../commons/ui_config.dart';
import '../main.dart';

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
              Container(
                alignment: AlignmentDirectional.centerEnd,
                height: 40,
                // child: buildImageButton('assets/image/loading_flag.webp', () {
                //   toggleLang();
                // }, AppLocalizations.of(context)!.langCode, 40),
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
                  SizedBox(
                    height: 120,
                    child: Center(
                      child: Padding(
                          padding: const EdgeInsets.all(22),
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
