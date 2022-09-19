import 'package:flutter/material.dart';
import 'package:wotracker/core/constants/colors.dart';

class AppText {
  TextStyle headlineMedium = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: AppColor().black,
  );
  TextStyle headlineBold = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColor().black,
  );

  TextStyle headlineBoldBlue = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColor().blue,
  );

  TextStyle subHeadlineMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColor().black,
  );
  TextStyle timerBold = TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.bold,
    color: AppColor().black,
  );

  TextStyle labelMedium = TextStyle(
    fontSize: 20,
    color: AppColor().grey,
  );
}
