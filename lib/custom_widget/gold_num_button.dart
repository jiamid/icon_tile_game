import 'package:flutter/material.dart';
import '../commons/storage_manager.dart';

class GoldNumButton extends StatefulWidget {
  double height;

  GoldNumButton({super.key, this.height = 60});

  @override
  GoldNumButtonState createState() => GoldNumButtonState();
}

class GoldNumButtonState extends State<GoldNumButton> {
  @override
  void initState() {
    super.initState();
    refreshGold();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int gold = 1;

  refreshGold() async {
    gold =
        await StorageManager().getValue(StorageKey.gold);
    setState(() {});
    print('gold:$gold');
  }

  addGold() async {
    await StorageManager().setValue(StorageKey.gold, gold + 1);
    refreshGold();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [
      SizedBox(
        height: widget.height,
        width: double.infinity,
        child: Image.asset(
          'assets/image/loading_flag.webp',
          fit: BoxFit.contain,
          alignment: Alignment.centerLeft,
        ),
      ),
    ];
    stackChildren.add(Positioned(
      left: widget.height,
      child: Text(
        gold.toString(),
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: widget.height / 2,
            height: 2,
            fontFamily: 'Baloo2',
            shadows: const [
              Shadow(
                  color: Color(0xFFB45509), blurRadius: 0, offset: Offset(0, 2))
            ],
            decoration: TextDecoration.none),
      ),
    ));
    return GestureDetector(
        onTap: addGold, child: Stack(children: stackChildren));
  }
}
