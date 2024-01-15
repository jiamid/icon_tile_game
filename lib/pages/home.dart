import 'package:flutter/material.dart';
import '../router/router_manager.dart';
import '/custom_widget/typing_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<TextLine> welcomeLines = [
    TextLine(
        bgColor: const Color(0xFFFCE0B7),
        textColor: Colors.black,
        text: 'Damn!!!',
        fontFamily: 'Baloo2',
        fontSize: 30),
    TextLine(
        bgColor: const Color(0xFFFCE0B7),
        textColor: Colors.white,
        text: 'So many pigs\nentered my zoo ',
        fontFamily: 'Baloo2',
        fontSize: 30),
    TextLine(
        bgColor: const Color(0xFFFCE0B7),
        textColor: Colors.red,
        text: 'Tile It!!!',
        fontFamily: 'Baloo2',
        fontSize: 30),
    // TextLine(
    //     bgColor: Colors.white, textColor: Colors.black, text: 'Hello Jiamid!'),
    // TextLine(
    //     bgColor: Colors.white, textColor: Colors.red, text: 'Love & Peace!'),
  ];

  List<TextLine> buttonLines = [];

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
                    lines: welcomeLines,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 120,
              child: Center(
                child: InkWell(
                  onTap: () {
                    GlobalPageRouter.replace(Pages.index, context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: TypingText(
                        lines: [
                          TextLine(
                              bgColor: Colors.black,
                              textColor: Colors.white,
                              text:
                                  '${AppLocalizations.of(context)!.playGame}!',
                              dot: '',
                              fontFamily:
                                  AppLocalizations.of(context)!.langCode == 'zh'
                                      ? 'Baloo2'
                                      : 'Baloo2',
                              fontWeight: FontWeight.bold,
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
