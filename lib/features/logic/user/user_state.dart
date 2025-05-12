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

// Navigate to Payment and Payouts

class NavigatePaymentPayout extends UserState {
  final UserDataModel userData;

  NavigatePaymentPayout({required this.userData});
}

// Navigate to Event Registered

class NavigateEventRegistered extends UserState {
  final UserDataModel userData;

  NavigateEventRegistered({required this.userData});
}

class NavigateToChat extends UserState {
  final ChatData chat;
  final UserDataModel userData;

  NavigateToChat({required this.chat, required this.userData});
}

class NavigateToOrganizerFollow extends UserState {
  final UserDataModel userData;

  NavigateToOrganizerFollow({required this.userData});
}
