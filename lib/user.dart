import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  bool? isVerified;
  final String? email;
  String? password;
  final String? displayName;

  UserModel({
    this.uid,
    this.isVerified,
    this.email,
    this.password,
    this.displayName,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
    };
  }

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uid = doc.id,
        email = doc.data()!["email"],
        displayName = doc.data()!["displayName"];

  UserModel copyWith({
    bool? isVerified,
    String? uid,
    String? email,
    String? password,
    String? displayName,
  }) {
    return UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        password: password ?? this.password,
        displayName: displayName ?? this.displayName,
        isVerified: isVerified ?? this.isVerified);
  }
}

// class UserModel {
//   final String? id;
//   final String? email;
//   final String? displayName;

//   UserModel({
//     this.id,
//     this.email,
//     this.displayName,
//   });
// }


