import 'package:flutter/material.dart';
import '../router/router_manager.dart';
import '/custom_widget/typing_text.dart';

class GameOverPage extends StatefulWidget {
  GameOverPage({super.key, this.gameStatus = false});

  bool gameStatus;

  @override
  GameOverPageState createState() => GameOverPageState();
}

class GameOverPageState extends State<GameOverPage> {
  List<TextLine> successLines = [
    TextLine(
        bgColor: Colors.white,
        textColor: Colors.red,
        text: '太棒了！！！',
        fontSize: 30),
    TextLine(
        bgColor: Colors.black,
        textColor: Colors.white,
        text: '你通过了最终的考验！！！',
        fontSize: 30),
    TextLine(
        bgColor: const Color(0xFF000000),
        textColor: Colors.white,
        text: '不愧是你!!!',
        fontSize: 30),
  ];

  List<TextLine> failLines = [
    TextLine(
        bgColor: Colors.white,
        textColor: Colors.black,
        text: '失败是常有的事情',
        fontSize: 40),
    TextLine(
        bgColor: Colors.black,
        textColor: Colors.white,
        text: '再来一次',
        fontSize: 40),
  ];

  List<TextLine> reLines = [
    TextLine(
        bgColor: Colors.black,
        textColor: Colors.white,
        text: '再来一次',
        dot: '',
        fontSize: 40),
  ];

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
                    lines: widget.gameStatus ? successLines : failLines,
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
                      borderRadius: BorderRadius.circular(20),
                      child: TypingText(
                        lines: reLines,
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
