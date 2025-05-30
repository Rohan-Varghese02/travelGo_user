part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class IntialSplashEvent extends AuthEvent {}

class GetStartedNavigationEvent extends AuthEvent {}

// Login Screen
class CheckLoginEvent extends AuthEvent {
  final String email;
  final String password;

  CheckLoginEvent({required this.email, required this.password});
}

class LogOutButtonClicked extends AuthEvent {}

class JoinButtonClicked extends AuthEvent {}

class VisibillityButtonClicked extends AuthEvent {
  final bool isVisible;

  VisibillityButtonClicked({required this.isVisible});
}

class ForgotPasswordEvent extends AuthEvent {}

class ResetPasswordEvent extends AuthEvent {
  final String email;

  ResetPasswordEvent({required this.email});
}

//Google Sigin
class GoogleSignInEvent extends AuthEvent {}

/// Register Screen
class AlreadyMemeber extends AuthEvent {}

class RegisterButtonEvent extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;

  RegisterButtonEvent({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

/// Register  Profile image

class PickImageEvent extends AuthEvent {}

class UploadImageEvent extends AuthEvent {
  final String imagePath;

  UploadImageEvent({required this.imagePath});
}

class SaveImageUrl extends AuthEvent {
  final String imageUrl;

  SaveImageUrl({required this.imageUrl});
}

class NoImageEvent extends AuthEvent {}

class RegisterUser extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String imageUrl;
  final String imagePublicID;

  RegisterUser({
    required this.imagePublicID,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.imageUrl,
  });

  //Logout from homescreen
}

class LogoutEvent extends AuthEvent {}
