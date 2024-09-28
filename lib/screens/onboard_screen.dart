import 'package:fauzi_driweather/core/constants/svg_assets.dart';
import 'package:fauzi_driweather/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home_screen.dart';

class OnboardPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const OnboardPage(),
      );
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColor.primary,
            AppColor.white,
          ],
        ),
      ),
      child: Center(
        child: Stack(
          children: [
            SvgPicture.asset(SvgAssets.circleHome),
            Positioned(
                top: 60,
                left: -40,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellowAccent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.yellow.withOpacity(0.5),
                        spreadRadius: 30,
                        blurRadius: 50,
                      ),
                    ],
                  ),
                )),
            Positioned(
              right: 0,
              top: 320,
              child: SvgPicture.asset(SvgAssets.cloud),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 80),
                  const Text(
                    "Never get caught\nin the rain again",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColor.black,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Stay ahead of the weather with our accurate\nforecasts",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColor.black,
                    ),
                  ),
                  const SizedBox(height: 23),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        HomePage.route(),
                        (route) => false,
                      );
                    },
                    child: const Text('Get Started'),
                  ),
                  const SizedBox(height: 141),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
