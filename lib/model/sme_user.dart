class SMEUserModel {
  String? uid;
  String? email;
  String? fullname;
  String? companyname;

  SMEUserModel({this.uid, this.email, this.fullname, this.companyname});

  // Firestore data
  factory SMEUserModel.fromMap(map) {
    return SMEUserModel(
        uid: map['uid'],
        email: map['email'],
        fullname: map['fullname'],
        companyname: map['companyname']);
  }

  // Receive firestore data

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullname': fullname,
      'companyname': companyname,
    };
  }
}
