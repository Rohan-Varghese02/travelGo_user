import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:travelgo_user/core/services/auth/authservice.dart';
import 'package:travelgo_user/core/services/local_storage.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<IntialSplashEvent>(intialSplashEvent);
    on<GetStartedNavigationEvent>(getStartedNavigationEvent);
    on<VisibillityButtonClicked>(visibillityButtonClicked);
    on<CheckLoginEvent>(checkLoginEvent);
    on<LogOutButtonClicked>(logOutButtonClicked);
    on<JoinButtonClicked>(joinButtonClicked);
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

  FutureOr<void> visibillityButtonClicked(
    VisibillityButtonClicked event,
    Emitter<AuthState> emit,
  ) {
    bool isVisible = event.isVisible;
    isVisible = !isVisible;
    emit(VisibleState(isVisible: isVisible));
  }

  FutureOr<void> checkLoginEvent(
    CheckLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    final auth = Authservice();
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
        event.email,
        event.password,
      );
      emit(LoginSuccessState(userCredential: user));
    } catch (e) {
      emit(LoginFailedState(error: e.toString()));
    }
  }

  FutureOr<void> logOutButtonClicked(
    LogOutButtonClicked event,
    Emitter<AuthState> emit,
  ) async {
    final auth = Authservice();
    await auth.signOut();
    emit(LogoutState());
  }

  FutureOr<void> joinButtonClicked(
    JoinButtonClicked event,
    Emitter<AuthState> emit,
  ) {
    emit(NavigateToRegister());
  }
}
