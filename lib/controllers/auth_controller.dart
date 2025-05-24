import 'dart:developer';
import 'package:autoguide/controllers/main_controller.dart';
import 'package:autoguide/data/keys_data.dart';
import 'package:autoguide/models/user_model.dart';
import 'package:autoguide/services/device_services.dart';
import 'package:autoguide/services/navigator_services.dart';
import 'package:autoguide/ui/dialog_ui.dart';
import 'package:autoguide/views/auth/screens/register_screen.dart';
import 'package:autoguide/views/user/screens/user_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthController {
  static AuthController? _instance;
  AuthController._privateConstructor();
  factory AuthController() {
    _instance ??= AuthController._privateConstructor();
    return _instance!;
  }
  GlobalKey<FormState> signInKey = GlobalKey();
  GlobalKey<FormState> signUpKey = GlobalKey();
  GlobalKey<FormState> forget = GlobalKey();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final birthController = TextEditingController();
  final pageController = PageController();
  final googleSignInx = GoogleSignIn();
  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final loading = ValueNotifier(false);
  GetStorage getStorage = GetStorage();
  AuthorizationCredentialAppleID? appleCredential;
  final mainController = MainController();
  UserModel? get userData => mainController.userDataNotifier.value;

  void dispose() {
    log('AuthController 🚫 dispose');
    _instance = null;
  }

  Future<void> saveAuthData() async {
    final token = await firebaseAuth.currentUser?.getIdToken();
    getStorage.write(KeysData.userData, userData?.toJson());
    getStorage.write(KeysData.token, token);
  }

  Future<void> createUser() async {
    await firestore
        .collection('users')
        .doc(userData!.uid)
        .set(userData!.toJson());
    saveAuthData();
  }

  Future<void> getUserData() async {
    mainController.userDataNotifier.value?.uid = firebaseAuth.currentUser!.uid;
    await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .get()
        .then((value) async {
          if (value.exists) {
            mainController.userDataNotifier.value = UserModel.fromJson(
              value.data() as Map,
            );
            saveAuthData();
          } else {
            logOut();
          }
        });
  }

  void logOut() {
    firebaseAuth.signOut();
    mainController.userDataNotifier.value = null;
    for (var e in KeysData.userKeys) {
      getStorage.remove(e);
    }
  }

  Future<void> appleSignIn() async {
    loading.value = true;

    try {
      appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final credential = OAuthProvider("apple.com").credential(
        idToken: appleCredential!.identityToken,
        accessToken: appleCredential!.authorizationCode,
      );
      mainController.userDataNotifier.value = UserModel(
        email: appleCredential?.email,
        firstName: appleCredential!.givenName ?? 'Apple',
        lastName: appleCredential!.familyName ?? 'user',
        authMethod: 'apple',
      );
      await credentialAuth(credential);
    } finally {
      loading.value = false;
    }
  }

  Future<void> googleSignIn() async {
    loading.value = true;
    try {
      GoogleSignInAccount? googleSignInAccount;

      googleSignInAccount = await googleSignInx.signIn();

      if (googleSignInAccount == null) {
        loading.value = false;
        return;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      var name = googleSignInAccount.displayName.toString().split(' ');

      mainController.userDataNotifier.value = UserModel(
        profile: googleSignInAccount.photoUrl ?? '',
        email: googleSignInAccount.email,
        firstName: name.first,
        lastName: name.length > 1 ? name.last : '',
        authMethod: 'google',
      );
      await credentialAuth(credential);
    } finally {
      loading.value = false;
    }
  }

  Future<void> credentialAuth(AuthCredential credential) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);
    bool isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;
    if (isNewUser) {
      await createUser();
      NavigatorServices.pushReplacement(RegisterScreen());
    } else {
      await getUserData();
      NavigatorServices.pushReplacement(UserScreen());
    }
  }

  Future<void> signUp() async {
    DeviceServices.unFocus();

    loading.value = true;

    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      loading.value = false;
      switch (e.code) {
        case 'email-already-in-use':
          DialogUI().showAlertDialog(
            'already_have_an_account',
            'this_email_address_is_associated_with_an_existing_account',
            yesBtn: 'ok',
            yesAction: () {
              NavigatorServices.pop();
            },
          );

          break;

        case 'too-many-requests':
          DialogUI().showAlertDialog(
            'too_many_requests',
            'try_again_later',
            yesBtn: 'ok',
            yesAction: () {
              NavigatorServices.pop();
            },
          );

          break;
        default:
          DialogUI().showAlertDialog(
            'error_occured',
            'e.message.toString()',
            yesBtn: 'ok',
            yesAction: () {
              NavigatorServices.pop();
            },
          );

          break;
      }
    }
  }

  Future<void> signIn() async {
    DeviceServices.unFocus();
    if (!signInKey.currentState!.validate()) {
      return;
    }
    loading.value = true;

    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      await getUserData();
      NavigatorServices.pushReplacement(UserScreen());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          DialogUI().showAlertDialog(
            'incorrect_password',
            'the_password_youve_entered_is_incorrect.please_try_again_to_sign_in',
            yesBtn: 'ok',
            yesAction: () {
              NavigatorServices.pop();
            },
          );

          break;
        case 'user-not-found' || 'invalid-email':
          DialogUI().showAlertDialog(
            'no_account_found.create_a_new_account?',
            'it_looks_like_the_email_address_isnt_connected_to_an_account.you_can_create_a_new_account_or_try_again',
            yesBtn: 'create_new_account',
            yesAction: () {
              NavigatorServices.pop();
            },
            cancelBtn: 'try_again',
            cancelAction: () {
              NavigatorServices.pop();
            },
          );

          break;
        case 'too-many-requests':
          DialogUI().showAlertDialog(
            'too_many_requests',
            'try_again_later',
            yesBtn: 'ok',
            yesAction: () {
              NavigatorServices.pop();
            },
          );

          break;
        default:
          DialogUI().showAlertDialog(
            'error_occured',
            'e.message.toString()',
            yesBtn: 'ok',
            yesAction: () {
              NavigatorServices.pop();
            },
          );

          break;
      }
    } finally {
      loading.value = false;
    }
  }
}
