import 'package:flutter/material.dart';
import '../router/router_manager.dart';
import '/custom_widget/typing_text.dart';
import '../l10n/app_localizations.dart';


class OldGameOverPage extends StatefulWidget {
  const OldGameOverPage({super.key, this.gameStatus = false});

  final bool gameStatus;

  @override
  OldGameOverPageState createState() => OldGameOverPageState();
}

class OldGameOverPageState extends State<OldGameOverPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  genLines(bool status) {
    if (status) {
      List<TextLine> successLines = [
        TextLine(
            bgColor: Colors.white,
            textColor: Colors.red,
            text: AppLocalizations.of(context)!.gameSuccessMsg,
            fontFamily: 'Baloo2',
            fontSize: 30)
      ];
      return successLines;
    } else {
      List<TextLine> failLines = [
        TextLine(
            bgColor: Colors.white,
            textColor: Colors.black,
            text: AppLocalizations.of(context)!.gameFailMsg,
            fontFamily: 'Baloo2',
            fontSize: 40)
      ];
      return failLines;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Color goTextColor = Color.fromRGBO(
    //         255 - Theme.of(context).scaffoldBackgroundColor.red,
    //         255 - Theme.of(context).scaffoldBackgroundColor.green,
    //         255 - Theme.of(context).scaffoldBackgroundColor.blue,
    //         0.5)
    //     .withAlpha(255);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: TypingText(
                    lines: genLines(widget.gameStatus),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 120,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    GlobalPageRouter.replace(Pages.gameRoom, context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: TypingText(
                        lines: [
                          TextLine(
                              bgColor: Colors.black,
                              textColor: Colors.white,
                              text: AppLocalizations.of(context)!.replay,
                              dot: '',
                              fontFamily: 'Baloo2',
                              fontSize: 40),
                        ],
                        hapticStatus: false,
                        loop: false,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
