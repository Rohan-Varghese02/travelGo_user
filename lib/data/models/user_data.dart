// class UserModel {
//   final String uid;
//   final String email;
//   final String role;

//   UserModel({required this.uid, required this.email, this.role = "user"});

//   Map<String, dynamic> toMap() {
//     return {"uid": uid, "email": email, "role": role};
//   }

//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       uid: map["uid"] ?? "",
//       email: map["email"] ?? "",
//       role: map["role"] ?? "user",
//     );
//   }
// }

class UserDataModel {
  final String name;
  final String uid;
  final String email;
  final String password;
  final String role;
  final String phoneNumber;
  final String imageUrl;

  UserDataModel({
    required this.name,
    required this.uid,
    required this.email,
    required this.password,
    this.role = 'user',
    required this.phoneNumber,
    required this.imageUrl,
  });
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "uid": uid,
      "email": email,
      "password": password,
      "role": role,
      "phoneNumber": phoneNumber,
      "imageUrl": imageUrl,
    };
  }
}
