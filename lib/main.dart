import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(create: (context) => CounterBloc(0), child: HomePage()),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc Listener'),
      ),
      body: Center(
        child: BlocListener<CounterBloc, int>(
          listener: (context, state) {
            if (state > 5) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Lebih dari 5'),
                  duration: Duration(milliseconds: 500),
                ),
              );
            }
          },
          child: BlocBuilder<CounterBloc, int>(
            builder: (context, state) {
              return Text('$state');
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CounterBloc>().increment(),
      ),
    );
  }
}

class CounterBloc extends Cubit<int> {
  CounterBloc(int initialState) : super(0);

  void increment() => emit(state + 1);
}
