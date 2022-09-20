import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import '../../injection.dart';
import '../bloc/cookie_bloc.dart';
import '../bloc/cookie_event.dart';
import '../cubit/countdown_cubit.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';

class RestTimer extends StatefulWidget {
  RestTimer({
    Key? key,
  }) : super(key: key);

  @override
  State<RestTimer> createState() => _RestTimerState();
}

class _RestTimerState extends State<RestTimer> {
  final double _blurRadius = 20;
  final double _opacity = 0.75;
  final Offset _offset = const Offset(9, 12);
  final double _borderRadius = 250;

  bool onTap = false;
  bool onCountdown = false;

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
          if (!onCountdown) {
            setState(() {
              onTap = true;
            });
          }
        },
        onTap: () async {
          if (!onCountdown) {
            getIt<CookieBloc>().add(AddCookieAmountEvent());
            setState(() {
              onTap = true;
              onCountdown = true;
            });

            await Future.delayed(const Duration(milliseconds: 70));

            setState(() {
              onTap = false;
            });

            await Future.delayed(const Duration(milliseconds: 200));

            final countdowncubit = getIt<CountdownCubit>();
            int timer = countdowncubit.timer;
            int countdown = countdowncubit.timer;

            for (int i = 0; i < countdowncubit.timer; i++) {
              countdown -= 1;
              countdowncubit.setCountDown(countdown);
              await Future.delayed(
                const Duration(seconds: 1),
              );
              countdowncubit.setCountDown(timer);
            }

            setState(() {
              onCountdown = false;
            });
          }
        },
        onLongPress: () {
          if (!onCountdown) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  'Set Timer',
                  style: AppText().headlineBold,
                ),
                content: TextField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  onSubmitted: (value) {
                    getIt<CookieBloc>().add(
                      SetCookieTimerEvent(
                        int.parse(value),
                      ),
                    );
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          }
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
          child: TextTimer(),
        ),
      ),
    );
  }
}

class TextTimer extends StatelessWidget {
  const TextTimer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder(
        bloc: getIt<CountdownCubit>(),
        builder: (context, state) {
          return Text(
            "$state",
            style: AppText().timerBold,
          );
        },
      ),
    );
  }
}
