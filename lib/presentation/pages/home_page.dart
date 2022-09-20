import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';
import '../../domain/usecases/get_today_date.dart';
import '../../injection.dart';
import '../bloc/cookie_event.dart';
import '../bloc/cookie_state.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import '../cubit/countdown_cubit.dart';
import '../widgets/done_button.dart';
import '../widgets/rest_timer.dart';

import '../bloc/cookie_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    CookieBloc bloc = getIt<CookieBloc>();
    bloc.add(GetCookieEvent());

    return Scaffold(
      backgroundColor: AppColor().background,
      body: SafeArea(
        child: Column(
          children: [
            // date
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Today',
                      style: AppText().subHeadlineMedium,
                    ),
                    Text(
                      getTodayDate(),
                      style: AppText().headlineBold,
                    ),
                  ],
                ),
              ),
            ),

            // records
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: NeomorphismButton(
                  borderRadius: 25,
                  inset: true,
                  child: BlocBuilder(
                    bloc: bloc,
                    builder: (context, state) {
                      if (state is LoadedState) {
                        return ListWheelScrollView(
                          itemExtent: 100,
                          physics: const FixedExtentScrollPhysics(),
                          children: state.cookie.records
                              .map(
                                (e) => RecordItem(
                                  date: e.date,
                                  amount: e.amount,
                                ),
                              )
                              .toList(),
                        );
                      } else {
                        return Center(
                          child: Text(
                            '-',
                            style: AppText().headlineBold,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),

            // timer
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: BlocBuilder(
                          bloc: bloc,
                          builder: (context, state) {
                            if (state is LoadedState) {
                              getIt<CountdownCubit>()
                                  .setTimer(state.cookie.timer);
                            } else {
                              getIt<CountdownCubit>().setTimer(15);
                            }
                            return RestTimer();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Click To Rest',
                          style: AppText().labelMedium,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
            ),

            // adder
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: DoneButton(),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    AspectRatio(
                      aspectRatio: 1 / 1,
                      child: GestureDetector(
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                'Set Adder',
                                style: AppText().headlineBold,
                              ),
                              content: TextField(
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                onSubmitted: (value) {
                                  getIt<CookieBloc>().add(
                                    SetCookieAdderEvent(
                                      int.parse(value),
                                    ),
                                  );
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          );
                        },
                        child: NeomorphismButton(
                          inset: true,
                          borderRadius: 15,
                          child: Center(
                            child: BlocBuilder(
                              bloc: bloc,
                              builder: (context, state) {
                                if (state is LoadedState) {
                                  return Text(
                                    "${state.cookie.adder}",
                                    style: AppText().headlineBold,
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecordItem extends StatelessWidget {
  String date;
  int amount;
  RecordItem({
    Key? key,
    required this.date,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: AppText().headlineBold,
          ),
          Text(
            "$amount",
            style: AppText().headlineBold,
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class NeomorphismButton extends StatefulWidget {
  bool inset;
  double borderRadius;
  Widget child;
  NeomorphismButton({
    Key? key,
    required this.child,
    this.inset = false,
    this.borderRadius = 250,
  }) : super(key: key);

  @override
  State<NeomorphismButton> createState() => _NeomorphismButtonState();
}

class _NeomorphismButtonState extends State<NeomorphismButton> {
  late bool _inset;
  late double _borderRadius;

  final double _blurRadius = 20;
  final double _opacity = 0.75;
  final Offset _offset = const Offset(9, 12);

  bool onTap = false;

  @override
  void initState() {
    super.initState();
    _inset = widget.inset;
    _borderRadius = widget.borderRadius;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTapCancel: () {
          if (!_inset) {
            setState(() {
              onTap = false;
            });
          }
        },
        onTapDown: (details) {
          if (!_inset) {
            setState(() {
              onTap = true;
            });
          }
        },
        onTapUp: (details) {
          if (!_inset) {
            setState(() {
              onTap = false;
            });
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
                inset: _inset,
              ),
              BoxShadow(
                color: AppColor()
                    .backgroundDarken
                    .withOpacity(onTap ? 0 : _opacity),
                offset: _offset,
                blurRadius: _blurRadius,
                inset: _inset,
              ),
            ],
          ),
          child: Center(
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
