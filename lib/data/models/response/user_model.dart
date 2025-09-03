// // To parse this JSON data, do
// //
// //     final userModel = userModelFromJson(jsonString);

// import 'dart:convert';

// UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

// String userModelToJson(UserModel data) => json.encode(data.toJson());

// List<UserData> usersListFromJson(String str) => List<UserData>.from(json.decode(str).map((x) => UserData.fromJson(x)));

// class UserModel {
//   UserModel({
//     required this.user,
//   });

//   UserData user;

//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         user: UserData.fromJson(json["user"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "user": user.toJson(),
//       };
// }

// class UserData {
//   UserData({
//     this.id,
//     this.name,
//     this.image,
//     this.email,
//     this.phone,
//     this.gender,
//     this.dob,
//     this.deviceId,
//     this.status,
//     this.company,
//     this.isAdmin,
//     this.emailVerifiedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   int? id;
//   String? name;
//   String? image;
//   String? email;
//   String? phone;
//   String? company;
//   String? gender;
//   DateTime? dob;
//   String? deviceId;
//   String? isAdmin;
//   String? status;
//   DateTime? emailVerifiedAt;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   factory UserData.fromJson(Map<String, dynamic> json) => UserData(
//         id: json["id"],
//         name: json["name"] ?? '',
//         image: json["image"] ?? '',
//         email: json["email"] ?? '',
//         phone: json["phone"] ?? '',
//         gender: json["gender"] ?? '',
//         dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
//         status: json["status"] ?? '',
//         deviceId: json["device_id"] ?? '',
//         company: json["company"] ?? '',
//         isAdmin: json["isAdmin"] ?? '',
//         emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "company": company,
//         "image": image,
//         "email": email,
//         "phone": phone,
//         "gender": gender,
//         "dob": dob?.toIso8601String(),
//         "isAdmin": isAdmin,
//         "email_verified_at": emailVerifiedAt?.toIso8601String(),
//         "device_id": deviceId,
//         "status": status,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

/// --- Helper Functions --- ///

// Parse single user from JSON string
UserModel userModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

// Convert single user to JSON string
String userModelToJson(UserModel data) => json.encode(data.toJson());

// Parse list of users from JSON string
List<UserModel> usersListFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

// Convert list of users to JSON string
String usersListToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


/// --- UserModel Class --- ///
class UserModel {
  final String uid;
  final String name;
  final String email;
  final String photoURL;
  final String provider;
  final DateTime? createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoURL,
    required this.provider,
    this.createdAt,
  });

  /// Firestore → Map
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "photoURL": photoURL,
      "provider": provider,
      "createdAt": createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
    };
  }

  /// Map → UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map["uid"] ?? "",
      name: map["name"] ?? "",
      email: map["email"] ?? "",
      photoURL: map["photoURL"] ?? "",
      provider: map["provider"] ?? "google",
      createdAt: map["createdAt"] != null
          ? (map["createdAt"] is Timestamp
              ? (map["createdAt"] as Timestamp).toDate()
              : DateTime.tryParse(map["createdAt"].toString()))
          : null,
    );
  }

  /// Firestore Document → UserModel
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel.fromMap(data);
  }

  /// JSON → UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      photoURL: json["photoURL"] ?? "",
      provider: json["provider"] ?? "google",
      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"])
          : null,
    );
  }

  /// UserModel → JSON
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "photoURL": photoURL,
      "provider": provider,
      "createdAt": createdAt?.toIso8601String(),
    };
  }

  /// Copy user with new values
  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? photoURL,
    String? provider,
    DateTime? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
      provider: provider ?? this.provider,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
