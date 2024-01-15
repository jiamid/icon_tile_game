import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import '../custom_widget/typing_text.dart';
import '../router/router_manager.dart';
import '../custom_widget/box_animation.dart' show runFlyBoxAnimate;
import 'game_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GameRoomPage extends StatefulWidget {
  const GameRoomPage({super.key});

  @override
  GameRoomPageState createState() => GameRoomPageState();
}

class GameRoomPageState extends State<GameRoomPage>
     {
  @override
  void initState() {
    super.initState();
    initMap();
  }

  List<GlobalKey> boxKeyList = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];
  List myBox = [];

  List<int> generateListFromList(List<int> levelTypeList) {
    List<int> tempTypeList = allType.toList();
    List<int> result = [];
    for (var value in levelTypeList) {
      int key = popRandomElement(tempTypeList);
      result.addAll(List.generate(value, (index) => key));
    }
    return result;
  }

  int popRandomElement(List<int> list) {
    if (list.isEmpty) {
      throw Exception('列表为空');
    }

    Random random = Random();
    int randomIndex = random.nextInt(list.length);

    // 从列表中随机弹出一个元素
    return list.removeAt(randomIndex);
  }

  int nowLevel = 1;
  int mapMaxWidth = 3;
  List<List<List<int>>> gameMap = [];

  List<int> floorDiffY = [1, 2, 3, 4, 5, 6, 7, 7, 7];
  List<int> floorDiffX = [1, 2, 3, 4, 5, 6, 7, 7, 7];

  initMap() {
    myBox = [];
    goBackTimes = 3;
    refreshTimes = 3;
    gameMap = (levelMap[nowLevel] ?? levelMap[1]!);
    floorDiffX = (levelOffsetMap[nowLevel]?[0] ?? levelOffsetMap[1]?[0])!;
    floorDiffY = (levelOffsetMap[nowLevel]?[1] ?? levelOffsetMap[1]?[1])!;
    List<int> thisLevelTypeList = levelTypeMap[nowLevel] ?? levelTypeMap[1]!;
    var allNums = generateListFromList(thisLevelTypeList);
    for (var i = 0; i < gameMap.length; i++) {
      for (var j = 0; j < gameMap[i].length; j++) {
        for (var k = 0; k < gameMap[i][j].length; k++) {
          mapMaxWidth = gameMap[i][j].length;
          if (gameMap[i][j][k] != -1) {
            gameMap[i][j][k] = popRandomElement(allNums);
          }
        }
      }
    }
    setState(() {});
  }

  int refreshTimes = 3;
  int resetTimes = 3;
  int goBackTimes = 3;
  List<Map> historyList = [];
  bool goBackStatus = false; // 用来防止关卡重置时快速点击返回导致问题

  goBack() {
    if (goBackTimes <= 0 || historyList.isEmpty) {
      return;
    }
    var lastOne = historyList[historyList.length - 1];
    myBox.removeAt(lastOne['boxIndex']);
    historyList.removeLast();
    goBackStatus = true;
    runFlyBoxAnimate(
        context,
        lastOne['endOffset'],
        lastOne['startOffset'],
        boxColorMap[lastOne['type']],
        oneBarWidth - 10,
        lastOne['startWidth'],
        'assets/box/${lastOne['type']}.webp', () {
      if (goBackStatus) {
        gameMap[lastOne['f']][lastOne['y']][lastOne['x']] = lastOne['type'];
      }
      setState(() {});
    });
    goBackTimes -= 1;
    setState(() {});
  }

  resetLevel() {
    if (resetTimes <= 0) {
      return;
    }
    historyList.clear();
    goBackStatus = false;
    resetTimes -= 1;
    initMap();
  }

  refreshMap() {
    if (refreshTimes <= 0) {
      return;
    }
    refreshTimes -= 1;
    List<int> allNums = [];
    for (var i = 0; i < gameMap.length; i++) {
      for (var j = 0; j < gameMap[i].length; j++) {
        for (var k = 0; k < gameMap[i][j].length; k++) {
          mapMaxWidth = gameMap[i][j].length;
          if (gameMap[i][j][k] > 0) {
            var thisNum = gameMap[i][j][k];
            allNums.add(thisNum);
          }
        }
      }
    }
    for (var i = 0; i < gameMap.length; i++) {
      for (var j = 0; j < gameMap[i].length; j++) {
        for (var k = 0; k < gameMap[i][j].length; k++) {
          mapMaxWidth = gameMap[i][j].length;
          if (gameMap[i][j][k] > 0) {
            gameMap[i][j][k] = popRandomElement(allNums);
          }
        }
      }
    }
    setState(() {});
  }

  addBoxStart(thisBox, f, y, x, startOffset, startWidth) {
    if (myBox.length == boxKeyList.length) {
      return;
    }
    int index = myBox.length;
    for (int x = myBox.length - 1; x >= 0; x--) {
      if (myBox[x]['type'] == thisBox['type']) {
        index = x + 1;
        break;
      }
    }
    if (index >= boxKeyList.length) {
      return;
    }
    GlobalKey key = boxKeyList[index];
    RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
    Offset end = box.localToGlobal(Offset.zero);
    setState(() {
      myBox.insert(index, thisBox);
      gameMap[f][y][x] = 0;
      historyList.add({
        'boxIndex': index,
        'type': thisBox['type'],
        'f': f,
        'y': y,
        'x': x,
        'startOffset': startOffset,
        'startWidth': startWidth,
        'endOffset': end
      });
    });
    return end;
  }

  bool checkAllZeros(List<List<List<int>>> array3D) {
    for (var i = 0; i < array3D.length; i++) {
      for (var j = 0; j < array3D[i].length; j++) {
        for (var k = 0; k < array3D[i][j].length; k++) {
          if (array3D[i][j][k] != 0 && array3D[i][j][k] != -1) {
            return false; // 只要有一个元素不是0，就返回false
          }
        }
      }
    }
    return true; // 如果所有元素都是0，返回true
  }

  chickBox() {
    var temp = {};
    for (int x = myBox.length - 1; x >= 0; x--) {
      var thisType = myBox[x]['type'];
      List nums = temp[thisType] ?? [];
      nums.add(x);
      temp[thisType] = nums;
      if (nums.length >= 3) {
        for (int i = 0; i < 3; i++) {
          myBox.removeAt(nums[i]);
          HapticFeedback.mediumImpact();
          historyList.clear();
          // HapticFeedback.selectionClick();
        }
        break;
      }
    }
    setState(() {});
    if (myBox.isEmpty) {
      if (checkAllZeros(gameMap)) {
        nowLevel += 1;
        if (!levelMap.containsKey(nowLevel)) {
          GlobalPageRouter.replace(Pages.gameOver, context,
              arguments: {'gameStatus': true});
        }
        initMap();
      }
    }
    if (myBox.length == boxKeyList.length) {
      GlobalPageRouter.replace(Pages.gameOver, context,
          arguments: {'gameStatus': false});
    }
  }

  bool checkPositioned(BuildContext context, width) {
    bool flag = true;
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    StackParentData targetData = renderBox.parentData as StackParentData;
    Rect rect = Rect.fromPoints(Offset(targetData.left!, targetData.top!),
        Offset(targetData.left! + width, targetData.top! + width));
    for (var i = stackChildrenList.length - 1; i > 0; i--) {
      var p = stackChildrenList[i] as Positioned;
      if (p.top == targetData.top && p.left == targetData.left) {
        break;
      }
      Rect pRect = Rect.fromPoints(
          Offset(p.left!, p.top!), Offset(p.left! + width, p.top! + width));
      if (rect.overlaps(pRect)) {
        flag = false;
        break;
      }
    }
    return flag;
  }

  Color darkenColor(Color color, double factor) {
    assert(
        factor >= 0.0 && factor <= 1.0, 'Factor should be between 0.0 and 1.0');

    int red = (color.red * (1.0 - factor)).round();
    int green = (color.green * (1.0 - factor)).round();
    int blue = (color.blue * (1.0 - factor)).round();

    return Color.fromARGB(color.alpha, red, green, blue);
  }

  Color lightenColor(Color color, double factor) {
    assert(
        factor >= 0.0 && factor <= 1.0, 'Factor should be between 0.0 and 1.0');

    int red = (color.red + (255 - color.red) * factor).round();
    int green = (color.green + (255 - color.green) * factor).round();
    int blue = (color.blue + (255 - color.blue) * factor).round();

    return Color.fromARGB(color.alpha, red, green, blue);
  }

  buildOneBox(int boxType, f, x, y, width, top, left) {
    width = width - 8;
    Color bgColor = lightenColor(boxColorMap[boxType], 0.95);
    Color borderColor = darkenColor(boxColorMap[boxType], 0.1);
    return Builder(
      builder: (c) {
        return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // 点击的时候获取当前 widget 的位置，传入 overlayEntry
                RenderBox box = c.findRenderObject() as RenderBox;
                var startOffset = box.localToGlobal(Offset.zero);
                if (!checkPositioned(c, width)) {
                  return;
                }
                var thisBox = {'type': boxType, 'status': 0};
                var endOffset =
                    addBoxStart(thisBox, f, y, x, startOffset, width);
                if (endOffset == null) {
                  return;
                }

                runFlyBoxAnimate(
                    c,
                    startOffset,
                    endOffset,
                    bgColor,
                    width,
                    oneBarWidth - 10,
                    'assets/box/$boxType.webp', () {
                  thisBox['status'] = 1;
                  setState(() {});
                  chickBox();
                },borderColor: borderColor
                );
              },
              child: Container(
                width: width - 1,
                height: width - 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: borderColor, // 边框颜色
                    width: 2, // 边框宽度
                  ),
                  color: bgColor,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    'assets/box/$boxType.webp',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ));
      },
    );
  }

  List<Widget> stackChildrenList = [];

  buildMap() {
    var width = MediaQuery.of(context).size.width - 20;
    var oneWidth = width / mapMaxWidth;

    var boxWidth = width + 4;
    var boxHeight = width + 4 + 20;

    var base = Container(
      height: boxHeight,
      width: boxWidth,
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black54, // 边框颜色
          width: 2.0, // 边框宽度
        ),
      ),
    );
    List<Widget> allFloor = [
      base,
    ];
    for (int floor = 0; floor < gameMap.length; floor++) {
      var oneFloor = gameMap[floor];
      for (int y = 0; y < oneFloor.length; y++) {
        for (int x = 0; x < oneFloor[y].length; x++) {
          int boxType = oneFloor[y][x];
          if (boxType != 0 && boxType != -1) {
            var top = oneWidth * y + floorDiffY[floor];
            var left = oneWidth * x + floorDiffX[floor];
            var one = Positioned(
                child: buildOneBox(boxType, floor, x, y, oneWidth, top, left),
                top: top + 8,
                left: left + 2);
            allFloor.add(one);
          }
        }
      }
    }
    stackChildrenList = allFloor;
    return Stack(
      children: allFloor,
    );
  }

  buildClickImageButton(imgPath, onPressed, {times}) {
    List<Widget> stackChildren = [
      SizedBox(
          height: 60,
          width: 60,
          child: InkWell(
            onTap: onPressed,
            child: Image.asset(imgPath),
          )),
    ];
    if (times != null) {
      stackChildren.add(Positioned(
          left: 40,
          child: Container(
            height: 20,
            width: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.red,
            ),
            child: Text(times),
          )));
    }
    return Stack(children: stackChildren);
  }

  buildClickButton(child, onPressed, {times}) {
    List<Widget> stackChildren = [
      SizedBox(
          height: 60,
          width: 60,
          child: ElevatedButton(
            style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                // foregroundColor: MaterialStateProperty.all(Colors.cyan),
                // overlayColor: MaterialStateProperty.all(pickColor.withAlpha(50)),
                backgroundColor: MaterialStateProperty.all(Colors.black),
                elevation: MaterialStateProperty.all(0),
                // shadowColor: MaterialStateProperty.all(pickColor),
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(70)),
                  ),
                )),
            onPressed: onPressed,
            child: child,
          )),
    ];
    if (times != null) {
      stackChildren.add(Positioned(
          left: 40,
          child: Container(
            height: 20,
            width: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.red,
            ),
            child: Text(times),
          )));
    }
    return Stack(children: stackChildren);
  }

  @override
  Widget build(BuildContext context) {
    Color goTextColor = Color.fromRGBO(
            255 - Theme.of(context).scaffoldBackgroundColor.red,
            255 - Theme.of(context).scaffoldBackgroundColor.green,
            255 - Theme.of(context).scaffoldBackgroundColor.blue,
            0.5)
        .withAlpha(255);
    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 在这里添加你的界面元素
                SizedBox(
                    height: 100,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          buildClickImageButton('assets/image/back.webp', () {
                            GlobalPageRouter.replace(Pages.home, context);
                          }),
                          const SizedBox(
                            width: 40,
                          ),
                          Expanded(
                            child: Container(
                              height: 52,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/image/rectangle_bg.webp'),
                                      fit: BoxFit.fill)),
                              child: Text(
                                AppLocalizations.of(context)!.level(nowLevel),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 36,
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
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ])),
                buildMap(),
                const Spacer(),
                buildBarBox(),
                SizedBox(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildClickButton(
                            const Icon(Icons.screen_rotation_alt_rounded), () {
                          refreshMap();
                        }, times: refreshTimes.toString()),
                        buildClickButton(const Icon(Icons.swipe_left), () {
                          goBack();
                        }, times: goBackTimes.toString()),
                        buildClickButton(
                            const Icon(Icons.settings_backup_restore_rounded),
                            () {
                          resetLevel();
                        }, times: resetTimes.toString()),
                      ],
                    ))
              ],
            )));
  }

  @override
  void dispose() {
    super.dispose();
  }

  double oneBarWidth = 0;

  buildBarBox() {
    var width = MediaQuery.of(context).size.width - 16;
    oneBarWidth = width / boxKeyList.length;
    var base = Container(
      height: oneBarWidth + 6,
      width: width,
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black54, // 边框颜色
          width: 2.0, // 边框宽度
        ),
      ),
    );
    List<Widget> boxItems = [base];
    for (int index = 0; index < boxKeyList.length; index++) {
      var oneChoice = 0;
      if (index < myBox.length && myBox[index]['status'] == 1) {
        oneChoice = myBox[index]['type'];
      }
      Color bgColor = lightenColor(boxColorMap[oneChoice], 0.95);
      Color borderColor = darkenColor(boxColorMap[oneChoice], 0.1);
      var one = Positioned(
        top: 8,
        left: oneBarWidth * index,
        child: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Container(
              key: boxKeyList[index],
              width: oneBarWidth - 10,
              height: oneBarWidth - 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: borderColor, // 边框颜色
                  width: 2.0, // 边框宽度
                ),
                color: bgColor,
              ),
              child: oneChoice != 0
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/box/$oneChoice.webp',
                        fit: BoxFit.cover,
                      ))
                  : null),
        ),
      );
      boxItems.add(one);
    }

    return Stack(children: boxItems);
  }
}