import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:store_app/utile/tost.dart';

class MyAuthFirebase {
  MyAuthFirebase._();

  static const String USER_NOT_FOUND_EXCEPTION_CODE = "user-not-found";
  static const String WRONG_PASSWORD_EXCEPTION_CODE = "wrong-password";
  static const String TOO_MANY_REQUESTS_EXCEPTION_CODE = 'too-many-requests';
  static const String EMAIL_ALREADY_IN_USE_EXCEPTION_CODE =
      "email-already-in-use";
  static const String OPERATION_NOT_ALLOWED_EXCEPTION_CODE =
      "operation-not-allowed";
  static const String WEAK_PASSWORD_EXCEPTION_CODE = "weak-password";
  static const String USER_MISMATCH_EXCEPTION_CODE = "user-mismatch";
  static const String INVALID_CREDENTIALS_EXCEPTION_CODE = "invalid-credential";
  static const String INVALID_EMAIL_EXCEPTION_CODE = "invalid-email";
  static const String USER_DISABLED_EXCEPTION_CODE = "user-disabled";
  static const String INVALID_VERIFICATION_CODE_EXCEPTION_CODE =
      "invalid-verification-code";
  static const String INVALID_VERIFICATION_ID_EXCEPTION_CODE =
      "invalid-verification-id";
  static const String REQUIRES_RECENT_LOGIN_EXCEPTION_CODE =
      "requires-recent-login";

  static MyAuthFirebase _instance = MyAuthFirebase._();
  BuildContext _context;

  static MyAuthFirebase get instance {
    return _instance;
  }

  MyAuthFirebase setContext(BuildContext context) {
    this._context = context;
    return this;
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get auth => _auth;

  Stream<User> get authStateChanges => _auth.authStateChanges();

  Stream<User> get userChanges => _auth.userChanges();

  User get currentUser {
    return _auth.currentUser;
  }

  Future<void> deleteUserAccount() async {
    await currentUser.delete();
    await logout();
  }


  Future<UserCredential> sigIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (_context != null) ToastMessage.showToast(e.message ?? "", false);

      print('Excepton : ${e.code} :: Message ${e.message}');
      if (e.code == 'invalid-email') {
      } else if (e.code == 'user-disabled') {
      } else if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {}
    } catch (exception) {
      print('sigIn :Excepton : $exception');
    }
    return null;
  }

  Future<String> creatAccount(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user.uid;
    } on FirebaseAuthException catch (e) {
      print('Excepton : ${e.code} :: Message ${e.message}');
      if (_context != null) {
        ToastMessage.showToast(e.message ?? "", false);
        if (e.code == 'invalid-email') {
          ToastMessage.showToast("invalid-email", false);
        } else if (e.code == 'operation-not-allowed') {
          ToastMessage.showToast("operation-not-allowed", false);
        } else if (e.code == 'weak-password') {
          ToastMessage.showToast("weak-password", false);
        } else if (e.code == 'email-already-in-use') {
          ToastMessage.showToast("email-already-in-use", false);
        }
      }
    } catch (exception) {
      print('creatAccount :Excepton : $exception');
    }
    return null;
  }

  logout() async {
    await _auth.signOut();
  }

  bool isLogin() {
    if (_auth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  forgetPasswoed(String email) async {
    _auth.sendPasswordResetEmail(email: email);
  }

  vrifyEmail() {
    _auth.currentUser.sendEmailVerification();
  }
}
