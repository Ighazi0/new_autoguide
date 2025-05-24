import 'package:autoguide/controllers/main_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  final firestore = FirebaseFirestore.instance;
  final userData = MainController().userDataNotifier.value;

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
