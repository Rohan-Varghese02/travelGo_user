part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class FetchIntialDetails extends UserEvent {}
// Profile Page ---- Events

class FullProfileEvent extends UserEvent {
  final UserDataModel userData;

  FullProfileEvent({required this.userData});
}
// Profile Page ----Update Profile Events

class UpdateImageEvent extends UserEvent{}

class ProfileUpdatIntiate extends UserEvent{}

class UpdateProfileEvent extends UserEvent {
  final String imagePublicID;
  final String imageUrl;
  final String uid;
  final String? imagePath;
  final String name;
  final String email;
  final String phone;


  UpdateProfileEvent({
    required this.imagePublicID,
    required this.imageUrl,
    required this.uid,
    required this.imagePath,
    required this.name,
    required this.email,
    required this.phone,
  });

}

///Journal

class JournalAddEvent extends UserEvent {}
