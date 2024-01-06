import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class TextLine {
  Color bgColor;
  Color textColor;
  String text;
  double? fontSize;
  String? dot;

  TextLine({
    required this.bgColor,
    required this.textColor,
    required this.text,
    this.fontSize,
    this.dot,
  });
}

class TypingText extends StatefulWidget {
  TypingText(
      {super.key,
      required this.lines,
      this.hapticStatus = true,
      this.loop = true})
      : assert(lines.isNotEmpty);

  final List<TextLine> lines;
  bool hapticStatus;
  bool loop;

  @override
  TypingTextState createState() => TypingTextState();
}

class TypingTextState extends State<TypingText> {
  int _configIndex = 0;
  int _textIndex = 0;
  bool typingFlag = true;

  late Future futureTyping;

  @override
  void initState() {
    super.initState();
    _runTyping(const Duration(milliseconds: 100));
  }

  void hapticFeedback() {
    if (widget.hapticStatus) {
      HapticFeedback.selectionClick();
    }
  }

  void _runTyping(Duration duration) {
    if (typingFlag) {
      futureTyping = Future.delayed(duration, () {
        _textIndex++;
        if (!mounted) return;
        hapticFeedback();
        setState(() {});
        if (_textIndex == widget.lines[_configIndex].text.length) {
          typingFlag = false;
          if (_configIndex < widget.lines.length - 1 || widget.loop) {
            _runTyping(const Duration(milliseconds: 600));
          }
        } else {
          _runTyping(const Duration(milliseconds: 100));
        }
      });
    } else {
      futureTyping = Future.delayed(duration, () {
        _textIndex--;
        if (!mounted) return;
        hapticFeedback();
        setState(() {});
        if (_textIndex == 0) {
          typingFlag = true;
          _configIndex++;
          _configIndex = _configIndex % widget.lines.length;
          _runTyping(const Duration(milliseconds: 400));
        } else {
          _runTyping(const Duration(milliseconds: 20));
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var fontSize = widget.lines[_configIndex].fontSize;
    if (fontSize == null) {
      var width = MediaQuery.of(context).size.width;
      var textNums = widget.lines[_configIndex].text.length;
      fontSize = width / textNums;
    }
    var dot = widget.lines[_configIndex].dot ??= '●';

    String displayedText =
        widget.lines[_configIndex].text.substring(0, _textIndex);
    displayedText = '$displayedText$dot';
    return AnimatedContainer(
      width: double.infinity,
      height: double.infinity,
      duration: const Duration(seconds: 1),
      alignment: Alignment.center,
      color: widget.lines[_configIndex].bgColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Center(
            child: Localizations(
          locale: const Locale('zh'),
          delegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          child: Text(
            displayedText,
            style: TextStyle(
                fontSize: fontSize,
                color: widget.lines[_configIndex].textColor,
                fontWeight: FontWeight.bold),
          ),
        )),
      ),
    );
  }
}
