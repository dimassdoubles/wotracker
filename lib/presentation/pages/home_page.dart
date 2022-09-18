import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wotracker/injection.dart';
import 'package:wotracker/presentation/bloc/cookie_event.dart';
import 'package:wotracker/presentation/bloc/cookie_state.dart';

import '../bloc/cookie_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    CookieBloc bloc = getIt<CookieBloc>();
    bloc.add(GetCookieEvent());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // date
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.red,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(
                    child: Text('date'),
                  ),
                ),
              ),
            ),

            // records
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.green,
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Center(
                    child: Text('records'),
                  ),
                ),
              ),
            ),

            // timer
            Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.blue,
                child: Column(
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          color: Colors.white,
                          child: Center(
                            child: Text('timer'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: Center(
                        child: Text('info'),
                      ),
                    ),
                    SizedBox(
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
                padding: EdgeInsets.all(16),
                color: Colors.red,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: Center(
                          child: Text('done'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Container(
                        color: Colors.white,
                        child: Center(
                          child: Text('adder'),
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
