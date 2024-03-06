import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icon_tile_game/commons/global_manager.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../commons/ui_config.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  AboutPageState createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  // 'https://sites.google.com/view/vidplayermanagertermsofuse/home'
  String termsOfUseLink =
      'https://sites.google.com/view/vidplayermanagertermsofuse/home';

  // 'https://sites.google.com/view/vidplayermanagerprivacypolicy/home'
  String privacyPolicyLink =
      'https://sites.google.com/view/vidplayermanagerprivacypolicy/home';

  String version = '';

  initVersion() async {
    var packageInfo = await GlobalManager().packageInfo;
    print('package:$packageInfo');
    version = packageInfo.version;
    setState(() {});
  }

  @override
  void initState() {
    initVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
      alignment: Alignment.bottomCenter,
      child: Column(children: [
        Padding(padding: EdgeInsets.only(top: 120)),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/logo.webp',
            width: 60,
            fit: BoxFit.cover,
          ),
        ),

        Padding(padding: EdgeInsets.all(2)),
        Text(
          'Tile Zoo',
          style: TextStyle(
            fontSize: 24,
            // color: PLColors.brand,
            color: Colors.white,
            fontWeight: FontWeight.w900,
            // foreground: getPaintLinearGradient(),
          ),
        ),
        Padding(padding: EdgeInsets.all(2)),
        Text(
          'Version: $version',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        // Padding(padding: EdgeInsets.all(5)),
        // buildVoidActionItemLine('Update',
        //     icon:Icons.upload,
        //     tips: 'new version'),
        Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 40),
                    // padding: EdgeInsets.zero,
                    child: Container(
                        height: 30,
                        // color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                child: Text('Terms of Use',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: BaseColor.greyTextColor)),
                                onTap: () {
                                  launchUrlString(termsOfUseLink);
                                },
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                child: Text('Privacy Policy',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: BaseColor.greyTextColor)),
                                onTap: () {
                                  launchUrlString(privacyPolicyLink);
                                },
                              ),
                            ),
                          ],
                        )))))
      ]),
    ));
  }
}
