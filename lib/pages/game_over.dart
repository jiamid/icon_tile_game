import 'package:flutter/material.dart';
import '../custom_widget/background_box.dart';
import '../custom_widget/key_red_button.dart';
import '../custom_widget/key_zoo_board.dart';
import '../router/router_manager.dart';
import '/custom_widget/typing_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GameOverPage extends StatefulWidget {
  const GameOverPage({super.key, this.gameStatus = false});

  final bool gameStatus;

  @override
  GameOverPageState createState() => GameOverPageState();
}

class GameOverPageState extends State<GameOverPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundBox(
        image: const AssetImage('assets/image/bg.webp'),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 220,
                      child: KeyZooBoard(
                        data: widget.gameStatus
                            ? AppLocalizations.of(context)!.gameSuccessMsg
                            : AppLocalizations.of(context)!.gameFailMsg,
                        fontSize: 54,
                      )),
                  SizedBox(
                    height: 120,
                    child: Center(
                      child: Padding(
                          padding: const EdgeInsets.all(22),
                          child: KeyRedButton(
                            data: AppLocalizations.of(context)!.replay,
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
