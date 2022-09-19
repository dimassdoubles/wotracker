// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wotracker/core/constants/colors.dart';
import 'package:wotracker/core/constants/text_styles.dart';
import 'package:wotracker/domain/usecases/get_today_date.dart';
import 'package:wotracker/injection.dart';
import 'package:wotracker/presentation/bloc/cookie_event.dart';
import 'package:wotracker/presentation/bloc/cookie_state.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import '../bloc/cookie_bloc.dart';

List testList = [
  1,
  2,
  3,
  4,
  5,
  6,
  7,
];

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
                  child: ListWheelScrollView(
                    itemExtent: 100,
                    physics: const FixedExtentScrollPhysics(),
                    // diameterRatio: 1.5,
                    children: const [
                      RecordItem(),
                      RecordItem(),
                      RecordItem(),
                      RecordItem(),
                      RecordItem(),
                      RecordItem(),
                      RecordItem(),
                      RecordItem(),
                      RecordItem(),
                      RecordItem(),
                    ],
                  ),
                ),
              ),
            ),

            // timer
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.all(16),
                // color: Colors.blue,
                child: Column(
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: NeomorphismButton(
                          child: Text(
                            '60',
                            style: AppText().timerBold,
                          ),
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
                // color: Colors.red,
                child: Row(
                  children: [
                    Expanded(
                      child: NeomorphismButton(
                        child: Text(
                          'Done',
                          style: AppText().headlineBoldBlue,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    AspectRatio(
                      aspectRatio: 1 / 1,
                      child: NeomorphismButton(
                        inset: true,
                        borderRadius: 15,
                        child: Center(
                          child: Text(
                            '10',
                            style: AppText().headlineBold,
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
  const RecordItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Today',
            style: AppText().headlineBold,
          ),
          Text(
            '15',
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

// the widget i use for test the bloc
class TestBlocWidget extends StatelessWidget {
  const TestBlocWidget({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final CookieBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is LoadedState) {
              return Column(
                children: [
                  const SizedBox(
                    height: 72,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.cookie.records.length,
                      itemBuilder: (context, index) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(state.cookie.records[index].date),
                          Text("${state.cookie.records[index].amount}"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 72,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      bloc.add(
                        SetCookieTimerEvent(state.cookie.timer + 5),
                      );
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text("TIMER : ${state.cookie.timer}"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      bloc.add(
                        AddCookieAmountEvent(),
                      );
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text("ADDER : ${state.cookie.adder}"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                ],
              );
            } else if (state is ErrorState) {
              return Center(child: Text("ERROR: ${state.message}"));
            } else {
              return const Center(
                child: Text("Loading"),
              );
            }
          },
        ),
      ),
    );
  }
}
