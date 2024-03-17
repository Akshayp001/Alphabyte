import 'dart:convert';

class UserModel {
  String name;
  String? photoUrl;
  String type; //doctor / patient
  String? age;
  String email;
  String? id;
  String? gender;

  UserModel({
    required this.name,
    this.photoUrl,
    required this.type,
    this.age,
    required this.email,
    required this.id,
    this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      photoUrl: json['photoUrl'],
      type: json['type'],
      age: json['age'],
      email: json['email'],
      id: json['id'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'photoUrl': photoUrl,
      'type': type,
      'age': age,
      'email': email,
      'id': id,
      'gender': gender,
    };
  }
}
