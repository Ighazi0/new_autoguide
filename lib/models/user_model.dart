import 'dart:io';

import 'package:autoguide/services/format_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:autoguide/models/car_model.dart';

class UserModel {
  String? username;
  String? gender;
  String? name;
  String? email;
  String? profile;
  String? address;
  String? bio;
  String? uid;
  String? firstName;
  String? lastName;
  String? cover;
  String? type;
  String? phone;
  String? password;
  double? lat;
  double? long;
  String? storeId;
  String? nashmiId;
  String? authMethod;
  String? locale;
  bool? ios;
  Timestamp? createdAt;
  Timestamp? bornAt;
  Timestamp? blockedAt;
  Timestamp? deletedAt;
  Timestamp? onlineAt;
  Timestamp? verifiedAt;
  List? block;
  List? followUp;
  List? followingUp;
  List? tags;
  List<CarModel>? carData;

  UserModel({
    this.username,
    this.gender,
    this.email,
    this.password,
    this.name,
    this.firstName,
    this.lastName,
    this.profile,
    this.bornAt,
    this.type,
    this.uid,
    this.cover,
    this.address,
    this.bio,
    this.phone,
    this.createdAt,
    this.lat,
    this.long,
    this.ios,
    this.blockedAt,
    this.deletedAt,
    this.verifiedAt,
    this.onlineAt,
    this.block,
    this.tags,
    this.followUp,
    this.followingUp,
    this.carData,
    this.storeId,
    this.nashmiId,
    this.authMethod,
    this.locale,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'gender': gender,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'profile': profile,
      'address': address,
      'bio': bio,

      'cover': cover,
      'type': type ?? 'user',
      'uid': uid,
      'phone': phone,
      'lat': lat,
      'long': long,
      'ios': ios ?? Platform.isIOS,
      'password': password,
      'blocked': blockedAt?.toDate().toString(),
      'online': onlineAt?.toDate().toString(),
      'bornAt': bornAt?.toDate().toString(),
      'verifiedAt': verifiedAt?.toDate().toString(),
      'deletedAt': deletedAt?.toDate().toString(),
      'createdAt': (createdAt ?? Timestamp.now()).toDate().toString(),
      'block': block,
      'tags': tags,
      'followUp': followUp,
      'followingUp': followingUp,
      'car': carData?.map((e) => e.toJson()).toList(),
      'storeId': storeId,
      'nashmiId': nashmiId,
      'authMethod': authMethod,
      'locale': locale,
    };
  }

  factory UserModel.fromJson(Map json) {
    var cars = (json['car'] as List?) ?? [];

    String first = json['firstName'] ?? '';
    String last = json['lastName'] ?? '';

    return UserModel(
      username: json['username'],
      gender: json['gender'],
      email: json['email'],
      name: '$first $last',
      firstName: first,
      lastName: last,
      profile: json['profile'],
      address: json['address'],
      bio: json['bio'],

      cover: json['cover'],
      type: json['type'] ?? 'user',
      uid: json['uid'],
      phone: json['phone'],
      lat:
          (json['lat'] is num)
              ? json['lat'].toDouble()
              : double.tryParse(json['lat']?.toString() ?? '0'),
      long:
          (json['long'] is num)
              ? json['long'].toDouble()
              : double.tryParse(json['long']?.toString() ?? '0'),
      ios: json['ios'],
      bornAt: FormatServices.convertStringToTimestamp(json['bornAt']),
      blockedAt: FormatServices.convertStringToTimestamp(json['blockedAt']),
      onlineAt: FormatServices.convertStringToTimestamp(json['onlineAt']),
      verifiedAt: FormatServices.convertStringToTimestamp(json['verifiedAt']),
      deletedAt: FormatServices.convertStringToTimestamp(json['deletedAt']),
      createdAt: FormatServices.convertStringToTimestamp(json['createdAt']),
      block: json['block'] ?? [],
      tags: json['tags'] ?? [],
      followUp: json['followUp'] ?? [],
      followingUp: json['followingUp'] ?? [],
      carData:
          cars
              .map((e) => CarModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      storeId: json['storeId'],
      nashmiId: json['nashmiId'],
      authMethod: json['authMethod'],
      locale: json['locale'] ?? 'ar',
    );
  }
}
