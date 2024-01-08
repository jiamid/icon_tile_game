import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import '../custom_widget/typing_text.dart';
import '../router/router_manager.dart';
import 'box_animation.dart';
import 'game_config.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  IndexPageState createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    initMap();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
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

  String preTitle = '';
  int nowLevel = 1;
  int mapMaxWidth = 3;
  List<List<List<int>>> gameMap = [];

  List<int> floorDiffY = [1, 2, 3, 4, 5, 6, 7, 7, 7];
  List<int> floorDiffX = [1, 2, 3, 4, 5, 6, 7, 7, 7];

  runAnimate(tempContent, startOffset, endOffset, color, startWidth, endWidth,
      img, overCall) {
    var duration = const Duration(milliseconds: 300);
    OverlayEntry? overlayEntry = OverlayEntry(builder: (_) {
      return BoxAnimationPage(
          startPosition: startOffset,
          endPosition: endOffset,
          duration: duration,
          color: color,
          startWidth: startWidth,
          endWidth: endWidth,
          img: img);
    });
    // 显示Overlay
    Overlay.of(tempContent).insert(overlayEntry);
    // 等待动画结束
    Future.delayed(duration, () {
      overlayEntry?.remove();
      overlayEntry = null;
      overCall?.call();
    });
  }

  initMap() {
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
    // print(allNums);
    preTitle = '第$nowLevel关';
    setState(() {});
  }

  refreshMap() {
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

  addBoxStart(thisBox, f, y, x) {
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
    setState(() {
      myBox.insert(index, thisBox);
      gameMap[f][y][x] = 0;
    });
    var end = box.localToGlobal(Offset.zero);
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
      setState(() {
        preTitle = 'GAME OVER';
      });
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

  buildOneBox(int boxType, f, x, y, width, top, left) {
    width = width - 8;
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
                var endOffset = addBoxStart(thisBox, f, y, x);
                if (endOffset == null) {
                  return;
                }

                runAnimate(c, startOffset, endOffset, boxColorMap[boxType],
                    width, oneBarWidth - 10, 'assets/img/$boxType.webp', () {
                  thisBox['status'] = 1;
                  setState(() {});
                  chickBox();
                });

                // var duration = const Duration(milliseconds: 300);
                // OverlayEntry? overlayEntry = OverlayEntry(builder: (_) {
                //   return BoxAnimationPage(
                //       startPosition: startOffset,
                //       endPosition: endOffset,
                //       duration: duration,
                //       color: boxColorMap[boxType],
                //       startWidth: width,
                //       endWidth: oneBarWidth,
                //       img: 'assets/img/$boxType.webp');
                // });
                // // 显示Overlay
                // Overlay.of(c).insert(overlayEntry);
                //
                // // 等待动画结束
                // Future.delayed(duration, () {
                //   overlayEntry?.remove();
                //   overlayEntry = null;
                //   thisBox['status'] = 1;
                //   setState(() {});
                //   chickBox();
                // });
              },
              child: Container(
                width: width - 1,
                height: width - 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: boxColorMap[boxType], // 边框颜色
                    width: 2, // 边框宽度
                  ),
                  color: boxColorMap[boxType],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    'assets/img/$boxType.webp',
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

  buildClickButton(child, onPressed) {
    return SizedBox(
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
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 在这里添加你的界面元素
                SizedBox(
                  height: 100,
                  child: Text(
                    preTitle,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        decoration: TextDecoration.none),
                  ),
                ),
                buildMap(),
                const Spacer(),
                buildBarBox(),
                SizedBox(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildClickButton(const Icon(Icons.recycling_rounded),
                            () {
                          refreshMap();
                        }),
                        buildClickButton(const Icon(Icons.refresh), () {
                          nowLevel = 1;
                          myBox = [];
                          initMap();
                        }),
                      ],
                    ))
              ],
            )));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double oneBarWidth = 0;

  buildBarBox() {
    var width = MediaQuery.of(context).size.width - 20;
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
                  color: boxColorMap[oneChoice], // 边框颜色
                  width: 2.0, // 边框宽度
                ),
              ),
              child: oneChoice != 0
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/img/$oneChoice.webp',
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
