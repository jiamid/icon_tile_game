import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'page/index.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();

  static MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>()!;
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ThemeData lightTheme = ThemeData(
    // colorScheme: ColorScheme.fromSeed(seedColor: JiaColors.brand),
    // useMaterial3: true,
    primaryColor: const Color(0xFFD9D1A9),
    primaryIconTheme: const IconThemeData(
        color:  Color(0xFF0C0C0B),
        size: 30
    ),
    iconTheme: const IconThemeData(
        color:  Color(0xFF0C0C0B),
        size: 25
    ),
    scaffoldBackgroundColor: Colors.blueGrey,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
    // appBarTheme: AppBarTheme(backgroundColor: JiaColors.backgroundColor),
  );

  ThemeData darkTheme = ThemeData(
    // colorScheme: ColorScheme.fromSeed(seedColor: JiaColors.brand),
    // useMaterial3: true,
    primaryColor: const Color(0xFFD9D1A9),
    primaryIconTheme: const IconThemeData(
        color:  Color(0xFFFFFFFF),
        size: 30
    ),
    iconTheme: const IconThemeData(
        color:  Color(0xFFFFFFFF),
        size: 25
    ),
    scaffoldBackgroundColor: Colors.blueGrey,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
    // appBarTheme: AppBarTheme(backgroundColor: JiaColors.backgroundColor),
  );

  bool isDarkMode(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // 竖屏
    ]);
    return MaterialApp(
      initialRoute: '/',
      home: const IndexPage(),
      debugShowCheckedModeBanner: false,
      theme: isDarkMode(context) ? darkTheme : lightTheme,
    );
  }
}
