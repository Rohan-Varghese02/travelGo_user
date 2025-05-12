class OrganizerListData {
  final String name;
  final String uid;
  final String image;

  OrganizerListData({
    required this.name,
    required this.uid,
    required this.image,
  });

  Map<String, String> toMap() {
    return {'name': name, 'uid': uid, 'image': image};
  }

  factory OrganizerListData.fromFirestore(Map<String, dynamic> doc) {
    return OrganizerListData(
      name: doc['name'],
      uid: doc['uid'],
      image: doc['imageUrl'],
    );
  }
}
