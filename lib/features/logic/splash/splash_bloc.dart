import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:travelgo_user/core/local_storage.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<IntitalFetchEvent>(intitalFetchEvent);
  }

  FutureOr<void> intitalFetchEvent(
    IntitalFetchEvent event,
    Emitter<SplashState> emit,
  ) async {
    bool isFirstTime = await LocalStorage.isFirstLaunch();
    if (isFirstTime == true) {
      await LocalStorage.setFirstLaunch();
      emit(FirstLoadingState()); // landing page
    }
    else{
      
    }
  }
}
