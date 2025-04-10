class UserDataModel {
  final String name;
  final String uid;
  final String email;
  final String password;
  final String role;
  final String phoneNumber;
  final String imageUrl;
  final String imagePublicID;

  UserDataModel({
    required this.imagePublicID,

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
      "imagePublicID": imagePublicID,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      imagePublicID: map['imagePublicID'] ?? '',
      name: map['name'] ?? '',
      role: map['role'] ?? '',
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}

class UserUpdateModel {
  final String imagePublicID;
  final String name;
  final String uid;
  final String email;
  final String phoneNumber;
  final String imageUrl;

  UserUpdateModel({
    required this.imagePublicID,

    required this.name,
    required this.uid,
    required this.email,
    required this.phoneNumber,
    required this.imageUrl,
  });
  Map<String, dynamic> toMap() {
    return {
      "imagePublicID": imagePublicID,
      "name": name,
      "uid": uid,
      "email": email,
      "phoneNumber": phoneNumber,
      "imageUrl": imageUrl,
    };
  }

  factory UserUpdateModel.fromMap(Map<String, dynamic> map) {
    return UserUpdateModel(
      imagePublicID: map['imagePublicID'],
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
