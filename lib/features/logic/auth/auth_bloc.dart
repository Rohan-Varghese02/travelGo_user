import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:travelgo_user/core/local_storage.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<IntialSplashEvent>(intialSplashEvent);
    on<GetStartedNavigationEvent>(getStartedNavigationEvent);
  }

  FutureOr<void> intialSplashEvent(
    IntialSplashEvent event,
    Emitter<AuthState> emit,
  ) async {
    bool isFirst = await LocalStorage.isFirstLaunch();
    if (isFirst) {
      LocalStorage.setFirstLaunch();
      emit(FirstTimeLoading());
    } else {
      emit(OnceLoadedState());
    }
  }

  FutureOr<void> getStartedNavigationEvent(
    GetStartedNavigationEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(LoginPageNavigationState());
  }
}
