import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import '../../core/constants/text_styles.dart';

import '../../core/constants/colors.dart';
import '../../injection.dart';
import '../bloc/cookie_bloc.dart';
import '../bloc/cookie_event.dart';

class DoneButton extends StatefulWidget {
  DoneButton({
    Key? key,
  }) : super(key: key);

  @override
  State<DoneButton> createState() => _DoneButtonState();
}

class _DoneButtonState extends State<DoneButton> {
  final double _blurRadius = 20;
  final double _opacity = 0.75;
  final Offset _offset = const Offset(9, 12);
  final double _borderRadius = 250;

  bool onTap = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTapCancel: () {
          setState(() {
            onTap = false;
          });
        },
        onTapDown: (details) {
          setState(() {
            onTap = true;
          });
        },
        onTap: () async {
          getIt<CookieBloc>().add(AddCookieAmountEvent());
          setState(() {
            onTap = true;
          });

          await Future.delayed(const Duration(milliseconds: 70));

          setState(() {
            onTap = false;
          });
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_borderRadius),
            color: AppColor().background,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(onTap ? 0 : _opacity),
                offset: -_offset,
                blurRadius: _blurRadius,
              ),
              BoxShadow(
                color: AppColor()
                    .backgroundDarken
                    .withOpacity(onTap ? 0 : _opacity),
                offset: _offset,
                blurRadius: _blurRadius,
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Done',
              style: AppText().headlineBoldBlue,
            ),
          ),
        ),
      ),
    );
  }
}
