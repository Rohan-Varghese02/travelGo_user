import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:travelgo_user/core/services/api_services.dart';
import 'package:travelgo_user/core/services/auth/authservice.dart';
import 'package:travelgo_user/core/services/firestore_services.dart';
import 'package:travelgo_user/data/models/user_data.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    // Profile Page ---- Events
    on<FetchIntialDetails>(fetchIntialDetails);
    on<FullProfileEvent>(fullProfileEvent);
    on<UpdateImageEvent>(updateImageEvent);
    on<ProfileUpdatIntiate>(profileUpdatIntiate);
    on<UpdateProfileEvent>(updateProfileEvent);

    // Journal Page Events
    on<JournalAddEvent>(journalAddEvent);
  }

  // Profile Page ---- Events
  FutureOr<void> fullProfileEvent(
    FullProfileEvent event,
    Emitter<UserState> emit,
  ) {
    emit(NavigateToFullProfile(userData: event.userData));
  }

  // Journal Page Events
  FutureOr<void> journalAddEvent(
    JournalAddEvent event,
    Emitter<UserState> emit,
  ) {
    emit(JournalAddPage());
  }

  FutureOr<void> fetchIntialDetails(
    FetchIntialDetails event,
    Emitter<UserState> emit,
  ) async {
    final auth = Authservice();
    UserDataModel userData = await auth.getCurrentUserData();
    emit(ProfileDetailsFetched(userData: userData));
  }

  FutureOr<void> updateImageEvent(
    UpdateImageEvent event,
    Emitter<UserState> emit,
  ) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        emit(ProfileImageUpdatedSucess(imagePath: pickedFile.path));
      } else {
        emit(ProfileImageUpdateFailed(message: 'No image selected'));
      }
    } catch (e) {
      emit(ProfileImageUpdateFailed(message: "Error picking Image: $e"));
    }
  }

  FutureOr<void> profileUpdatIntiate(
    ProfileUpdatIntiate event,
    Emitter<UserState> emit,
  ) {
    emit(UserProfileIntiated());
  }

  FutureOr<void> updateProfileEvent(
    UpdateProfileEvent event,
    Emitter<UserState> emit,
  ) async {
    final api = ApiServices();
    String imagePublicID = event.imagePublicID;
    String imageUrl = event.imageUrl;

    try {
      if (event.imagePath != null) {
        if (event.imagePublicID.isNotEmpty || event.imagePublicID != 'null') {
          final deleted = await api.deleteImageFromCloudinary(
            event.imagePublicID,
          );
          if (!deleted) {
            log("Failed to delete old image.");
          }
        }
        Map<String, String> url = await api.getUploadUrl(event.imagePath!);
        imageUrl = url['imageUrl']!;
        imagePublicID = url['publicId']!;
      }
      UserUpdateModel user = UserUpdateModel(
        imagePublicID: imagePublicID,
        name: event.name,
        uid: event.uid,
        email: event.email,
        phoneNumber: event.phone,
        imageUrl: imageUrl,
      );
      final firestore = FirestoreService();
      await firestore.updateUserInFirestore(user);
      UserDataModel userData = await firestore.getUser(event.uid);
      emit(ProfileDetailsFetched(userData: userData));
      emit(ProfileUpdateSuccess());
    } catch (e) {
      log(e.toString());
      emit(ProfileImageUpdateFailed(message: 'Some error'));
    }
  }
}
