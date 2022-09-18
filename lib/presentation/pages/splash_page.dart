import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().background,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 4,
          ),
          width: double.infinity,
          child: Image.asset('assets/images/splash_icon.png'),
        ),
      ),
    );
  }
}
