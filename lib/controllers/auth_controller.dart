import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:venkatesh/data/models/response/response_model.dart';

import '../data/models/response/user_model.dart';
import '../data/repositories/auth_repo.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool _acceptTerms = true;

  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  bool get isLoading => _isLoading;

  // bool get acceptTerms => _acceptTerms;

  // static final FirebaseAuth _auth = FirebaseAuth.instance;
  // static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  // static bool isInitialize = false;

  // static Future<void> initSignIn() async {
  //   if (!isInitialize) {
  //     await _googleSignIn.initialize(
  //       serverClientId:
  //           "146315530249-iaqu5vtv1d9r59nqrltirsquenvj58oq.apps.googleusercontent.com",
  //     );
  //   }
  //   isInitialize = true;
  // }

  // Future<ResponseModel?> signInWithGoogle() async {
  //   ResponseModel responseModel;
  //   _isLoading = true;
  //   update();

  //   try {
  //     initSignIn();
  //     final GoogleSignInAccount gooogleUser = await _googleSignIn
  //         .authenticate();
  //     final idToken = gooogleUser.authentication.idToken;
  //     final authorizationClient = gooogleUser.authorizationClient;

  //     GoogleSignInClientAuthorization? authorization = await authorizationClient
  //         .authorizationForScopes(['email', 'profile']);

  //     final accessToken = authorization?.accessToken;
  //     if (acceptTerms == null) {
  //       final authorization2 = await authorizationClient.authorizationForScopes(
  //         ['email', 'profile'],
  //       );
  //       if (authorization2?.accessToken == null) {
  //         throw FirebaseAuthException(code: "Error", message: "error");
  //       }
  //       authorization = authorization2;
  //     }
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: accessToken,
  //       idToken: idToken,
  //     );

  //     final UserCredential userCredential = await FirebaseAuth.instance
  //         .signInWithCredential(credential);

  //     final User? user = userCredential.user;
  //     if (user != null) {
  //       final userDoc = FirebaseFirestore.instance
  //           .collection("users")
  //           .doc(user.uid);

  //       final docSnapshot = await userDoc.get();
  //       _userModel = UserModel(
  //         uid: user.uid,
  //         name: user.displayName ?? '',
  //         email: user.email ?? '',
  //         photoURL: user.photoURL ?? "",
  //         provider: "google",
  //         createdAt: DateTime.now(),
  //       );

  //       if (!docSnapshot.exists) {
  //         await userDoc.set(_userModel!.toMap());
  //       }
  //       responseModel = ResponseModel(
  //         true,
  //         "Login Successfully",
  //         userCredential,
  //       );
  //     }
  //   } catch (e) {
  //     responseModel = ResponseModel(true, "Login Fails", e);

  //     print('Error: $e');
  //   }
  //   _isLoading = false;
  //   update();
  // }

  // Future<ResponseModel> generatedOtp({required String phone}) async {
  //   log('----------- generatedOtp Called ----------');
  //
  //   ResponseModel responseModel;
  //   _isLoading = true;
  //   update();
  //
  //   try {
  //     Response response = await authRepo.generateOtp(phone: phone);
  //     if ((response.data as Map).containsKey('errors')) {
  //       Fluttertoast.showToast(msg: '${response.data['message']}', toastLength: Toast.LENGTH_LONG);
  //       responseModel = ResponseModel(false, response.statusMessage ?? '', response.data['errors']);
  //     } else if (response.statusCode == 200 && response.data['success']) {
  //       responseModel = ResponseModel(true, response.statusMessage ?? '', response.data['message']);
  //       Fluttertoast.showToast(msg: '${response.data['message']}', toastLength: Toast.LENGTH_LONG);
  //     } else {
  //       responseModel = ResponseModel(false, response.statusMessage ?? '', response.data['errors']);
  //     }
  //   } catch (e) {
  //     responseModel = ResponseModel(false, "CATCH");
  //     log('++++++++++++++ ${e.toString()} +++++++++++++++++++++++++', name: "ERROR AT generatedOtp()");
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }
  //
  // Future<ResponseModel> verifyOtp({required String phone, required String otp}) async {
  //   log('----------- verifyOtp Called ----------');
  //
  //   ResponseModel responseModel;
  //   _isLoading = true;
  //   update();
  //
  //   try {
  //     Response response = await authRepo.verifyOtp(phone: phone, otp: otp);
  //     if ((response.data as Map).containsKey('errors')) {
  //       Fluttertoast.showToast(msg: '${response.data['message']}', toastLength: Toast.LENGTH_LONG);
  //       responseModel = ResponseModel(false, response.statusMessage ?? '', response.data['errors']);
  //     } else if (response.statusCode == 200 && response.data['success']) {
  //       if (response.data['otp_verified']) {
  //         responseModel = ResponseModel(true, response.statusMessage ?? '');
  //         setUserToken(id: response.data['token']);
  //         Fluttertoast.showToast(msg: 'Otp Verified', toastLength: Toast.LENGTH_LONG);
  //       } else {
  //         responseModel = ResponseModel(true, response.statusMessage ?? '');
  //         Fluttertoast.showToast(msg: 'Incorrect Otp', toastLength: Toast.LENGTH_LONG);
  //       }
  //     } else {
  //       Fluttertoast.showToast(msg: 'Something Went Wrong', toastLength: Toast.LENGTH_LONG);
  //       responseModel = ResponseModel(false, response.statusMessage ?? '', response.data['errors']);
  //     }
  //   } catch (e) {
  //     responseModel = ResponseModel(false, "CATCH");
  //     log('++++++++++++++ ${e.toString()} +++++++++++++++++++++++++', name: "ERROR AT verifyOtp()");
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }
  //
  // Future<ResponseModel> logoutUser() async {
  //   log('----------------- logoutUser Called ----------------');
  //
  //   ResponseModel responseModel;
  //
  //   try {
  //     Response response = await authRepo.logoutUser();
  //
  //     if (response.statusCode == 200) {
  //       if (response.data['success'] == true && response.data['message'] != null) {
  //         clearSharedData();
  //         Navigator.pushAndRemoveUntil(navigatorKey.currentContext!, getCustomRoute(child: const LoginScreen()), (route) => false);
  //         responseModel = ResponseModel(true, response.statusMessage ?? '');
  //         Fluttertoast.showToast(msg: response.data['message']);
  //       } else {
  //         responseModel = ResponseModel(false, response.statusMessage ?? '');
  //       }
  //     } else {
  //       responseModel = ResponseModel(false, response.statusMessage ?? '');
  //     }
  //   } catch (e) {
  //     responseModel = ResponseModel(false, "CATCH");
  //     log('++++++++++++++ ${e.toString()} +++++++++++++++++++++++++', name: "ERROR AT logoutUser()");
  //   }
  //
  //   return responseModel;
  // }
  //
  // Future<ResponseModel> getUserProfileData() async {
  //   log('----------- getUserProfileData Called ----------');
  //
  //   ResponseModel responseModel;
  //   _isLoading = true;
  //   update();
  //
  //   try {
  //     Response response = await authRepo.getUser();
  //     if (response.statusCode == 200) {
  //       log(response.data.toString(), name: 'ResponseDATA');
  //       if (response.data['success'] == true && response.data['data'] != null) {
  //         _userModel = UserModel.fromJson(response.data['data']);
  //         log(response.statusMessage!, name: "UserModel");
  //         authRepo.saveUserId('${_userModel!.id}');
  //         setGloabalViewStatus(status: _userModel?.isManager ?? false);
  //         responseModel = ResponseModel(true, '${response.statusMessage}');
  //       } else {
  //         responseModel = ResponseModel(false, response.statusMessage ?? '');
  //       }
  //     } else {
  //       ApiChecker.checkApi(response);
  //       responseModel = ResponseModel(false, "${response.statusMessage}");
  //     }
  //   } catch (e) {
  //     log('---- ${e.toString()} ----', name: "ERROR AT getUserProfileData()");
  //     responseModel = ResponseModel(false, "$e");
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }

  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  void setUserToken({required String id}) async {
    await authRepo.saveUserToken(id);
    // getUserProfileData();
  }
}
