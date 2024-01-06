import 'package:flutter/material.dart';
import '../router/router_manager.dart';
import '/custom_widget/typing_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<TextLine> welcomeLines = [
    TextLine(
        bgColor: Colors.black,
        textColor: Colors.white,
        text: '这是一个简单的小游戏',
        fontSize: 25),
    TextLine(
        bgColor: Colors.black,
        textColor: Colors.white,
        text: '通过收集三个相同的图标来消除它们',
        fontSize: 25),
    TextLine(
        bgColor: const Color(0xFF260C10),
        textColor: Colors.red,
        text: '你的任务是将画面中的所有图标消除!!!',
        fontSize: 25),
    TextLine(
        bgColor: const Color(0xFF260C10),
        textColor: const Color(0xFFFFFFFF),
        text: '你有7个格子、n请不要把它们用光了！',
        fontSize: 30),
    TextLine(
        bgColor: Colors.white,
        textColor: Colors.black,
        text: '开始游戏请点击下方按钮\n没看清再看一遍',
        fontSize: 30),
    // TextLine(
    //     bgColor: Colors.white, textColor: Colors.black, text: 'Hello Jiamid!'),
    // TextLine(
    //     bgColor: Colors.white, textColor: Colors.red, text: 'Love & Peace!'),
  ];

  List<TextLine> buttonLines = [
    TextLine(
        bgColor: Colors.white,
        textColor: Colors.black,
        text: '勇士！！！',
        dot: '',
        fontSize: 40),
    TextLine(
        bgColor: Colors.white,
        textColor: Colors.black,
        text: '点击这里',
        fontSize: 40),
    TextLine(
        bgColor: Colors.black,
        textColor: Colors.white,
        text: '开始游戏',
        dot: ' ->',
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
                      borderRadius: BorderRadius.circular(20),
                      child: TypingText(
                        lines: buttonLines,
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
