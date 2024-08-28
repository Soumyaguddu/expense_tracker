import 'package:expense_tracker/blocs/internet_blocs/internet_bloc.dart';
import 'package:expense_tracker/blocs/internet_blocs/internet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/internet_cubit/internet_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: BlocConsumer<InternetBloc, InternetBlocState>(
          builder: (BuildContext context, InternetBlocState state) {
            if (state is InternetGainState) {
              return const Text("Internet Connected...");
            } else if (state is InternetLossState) {
              return const Text("Internet Not Connected...");
            } else {
              return const Text("Loading...");
            }
          },
          listener: (BuildContext context, InternetBlocState state) {
            if (state is InternetGainState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Internet Connected!"),
                  backgroundColor: Colors.green));
            }
           else if (state is InternetLossState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Internet Not Connected!"),
                  backgroundColor: Colors.red));
            }
          },
        )),
      ),
    );
  }
}
