import 'package:flutter/material.dart';
import 'package:icon_tile_game/commons/global_manager.dart';
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

  toggleLang() async {
    GlobalManager()
        .globalKey
        .currentContext
        ?.findAncestorStateOfType<MyAppState>()!
        .toggleLang();
    setState(() {});
  }

  buildImageButton(String imgPath, onPressed, text,double width) {
    return Container(
        alignment: Alignment.center,
        decoration:
            BoxDecoration(image: DecorationImage(image: AssetImage(imgPath))),
        width: width,
        child: InkWell(
          onTap: onPressed,
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 20,
                height: 1.1,
                fontFamily: 'Baloo2',
                shadows: [
                  Shadow(
                      color: Color(0xFFB45509),
                      blurRadius: 0,
                      offset: Offset(0, 2))
                ],
                decoration: TextDecoration.none),
          ),
        ));
  }

  buildStartButton() {
    return ClipRRect(
      key: UniqueKey(),
      borderRadius: BorderRadius.circular(18),
      child: TypingText(
        lines: [
          TextLine(
              bgColor: const Color(0xFFEE3E08),
              textColor: Colors.white,
              text: AppLocalizations.of(context)!.playGame,
              dot: '!',
              fontFamily: AppLocalizations.of(context)!.langCode == 'zh'
                  ? 'Baloo2'
                  : 'Baloo2',
              fontWeight: FontWeight.bold,
              fontSize: 40),
        ],
        hapticStatus: false,
        loop: false,
      ),
    );
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
            Container(
              alignment: AlignmentDirectional.centerEnd,
              height: 40,
              child: buildImageButton('assets/image/loading_flag.webp', () {
                toggleLang();
              }, AppLocalizations.of(context)!.langCode, 40),
            ),
            SizedBox(
              height: 120,
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/image/tile_zoo.webp'),
                )),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
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
                    // GlobalPageRouter.replace(Pages.index, context);
                    GlobalPageRouter.replace(Pages.fakeLoadingPage, context,
                        arguments: {
                          'duration': const Duration(milliseconds: 500),
                          'nextPage': Pages.index,
                          'args': {}
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFCE0B7),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(color: shadowColor, offset: shadowOffset)
                        ],
                      ),
                      child: buildStartButton(),
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
