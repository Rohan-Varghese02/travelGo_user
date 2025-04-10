part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

class ProfileDetailsFetched extends UserState {
  final UserDataModel userData;

  ProfileDetailsFetched({required this.userData});
}

// Profile Page ---- Events

class NavigateToFullProfile extends UserState {
  final UserDataModel userData;

  NavigateToFullProfile({required this.userData});
}

// Profile Page ----Profile Update Events

class ProfileImageUpdatedSucess extends UserState {
  final String imagePath;

  ProfileImageUpdatedSucess({required this.imagePath});
}

class ProfileImageUpdateFailed extends UserState {
  final String message;

  ProfileImageUpdateFailed({required this.message});
}

class UserProfileIntiated extends UserState {}

class ProfileUpdateSuccess extends UserState {}

class ProfileUpdateFailed extends UserState {}


/// Journal
class JournalAddPage extends UserState {}
