class UserModel {
  String? uid;
  String? email;
  String? fullname;

  UserModel({this.uid, this.email, this.fullname});

  // Firestore data
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      fullname: map['fullname'],
    );
  }

  // Receive firestore data

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullname': fullname,
    };
  }
}
