import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:expense_tracker/blocs/internet_blocs/internet_event.dart';
import 'package:expense_tracker/blocs/internet_blocs/internet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetBloc extends Bloc<InternetEvent, InternetBlocState> {
  final Connectivity _connectivity = Connectivity();
StreamSubscription? connectivitySubscription;
  InternetBloc() : super(InternetInitialState()) {

    on<InternetLostEvent>((event, emit) => emit(InternetLossState()));
    on<InternetGainedEvent>((event, emit) => emit(InternetGainState()));
  connectivitySubscription=  _connectivity.onConnectivityChanged.listen((result) {
      if(result==ConnectivityResult.mobile||result==ConnectivityResult.wifi)
        {
          add(InternetGainedEvent());
        }
      else
        {
          add(InternetLostEvent());
        }

    });
  }
  @override
  Future<void> close() {
   connectivitySubscription?.cancel();
    return super.close();
  }

}
