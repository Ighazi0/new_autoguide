import 'dart:developer';

import 'package:autoguide/controllers/main_controller.dart';
import 'package:autoguide/models/banner_model.dart';
import 'package:autoguide/models/categories_model.dart';
import 'package:autoguide/services/device_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetDataServices {
  final firestore = FirebaseFirestore.instance;
  final userData = MainController().userData;

  Future<List<CategoryModel>> getCategoriesStores() async {
    final data = DeviceServices().getcachedData('getCategoriesStores') as List?;
    if (data == null) {
      try {
        final querySnapshot = await firestore
            .collection('storesCategories')
            .orderBy('sort', descending: true)
            .get();
        DeviceServices().cacheData(
          'getCategoriesStores',
          querySnapshot.docs.map((doc) {
            return doc.data();
          }).toList(),
        );

        return querySnapshot.docs.map((doc) {
          return CategoryModel.fromJson(doc.data());
        }).toList();
      } catch (e) {
        log("getCategoriesStores ❌ $e");
        return [];
      }
    } else {
      final categories = data
          .map((value) => CategoryModel.fromJson(value))
          .toList();
      return categories;
    }
  }

  Future<List<BannerModel>> getBanners() async {
    final data = DeviceServices().getcachedData('getBanners') as List?;
    if (data == null) {
      try {
        final querySnapshot = await firestore.collection('banners').get();
        DeviceServices().cacheData(
          'getBanners',
          querySnapshot.docs.map((doc) {
            return doc.data();
          }).toList(),
        );

        return querySnapshot.docs.map((doc) {
          return BannerModel.fromJson(doc.data());
        }).toList();
      } catch (e) {
        log("getBanners ❌ $e");
        return [];
      }
    } else {
      final banners = data.map((value) => BannerModel.fromJson(value)).toList();
      return banners;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getChatCount() {
    if (userData != null) {
      return firestore
          .collection('users')
          .doc(userData?.uid)
          .collection('chats')
          .where('clicked', isEqualTo: false)
          .snapshots();
    }
    return null;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getNotificationsCount() {
    if (userData != null) {
      return firestore
          .collection('users')
          .doc(userData?.uid)
          .collection('notifications')
          .where('clicked', isEqualTo: false)
          .snapshots();
    }
    return null;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getFriendsCount() {
    if (userData != null) {
      return firestore
          .collection('users')
          .doc(userData?.uid)
          .collection('friends')
          .snapshots();
    }
    return null;
  }
}
