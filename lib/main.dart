import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/home.dart';
import 'commons/storage_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
    initLocate();
  }

  toggleLang() async {
    if (nowLocale.languageCode == 'en') {
      await StorageManager().setString(StorageManager.KEY_LANGUAGE, 'zh');
      setLocate(const Locale('zh'));
    } else {
      await StorageManager().setString(StorageManager.KEY_LANGUAGE, 'en');
      setLocate(const Locale('en'));
    }
  }

  initLocate() async {
    String lang = await StorageManager()
        .getString(StorageManager.KEY_LANGUAGE, defValue: 'en');
    print('object:$lang');
    lang = 'zh';
    setState(() {
      nowLocale = Locale(lang);
    });
  }

  Locale nowLocale = const Locale('en');

  setLocate(Locale newLocate) {
    setState(() {
      nowLocale = newLocate;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  ThemeData lightTheme = ThemeData(
    // colorScheme: ColorScheme.fromSeed(seedColor: JiaColors.brand),
    // useMaterial3: true,
    primaryColor: const Color(0xFFD9D1A9),
    primaryIconTheme: const IconThemeData(color: Color(0xFF0C0C0B), size: 30),
    iconTheme: const IconThemeData(color: Color(0xFF0C0C0B), size: 25),
    scaffoldBackgroundColor: Colors.white,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
    // appBarTheme: AppBarTheme(backgroundColor: JiaColors.backgroundColor),
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // 竖屏
    ]);
    return MaterialApp(
      initialRoute: '/',
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: nowLocale,
    );
  }
}
