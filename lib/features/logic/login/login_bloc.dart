import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSumbittedEvent>(loginSumbittedEvent);
  }

  FutureOr<void> loginSumbittedEvent(
    LoginSumbittedEvent event,
    Emitter<LoginState> emit,
  ) {
    String email = event.email;
    String password = event.password;
    log('email : $email, password:$password');
    emit(LoginSubittedSuccessState());
  }
}
