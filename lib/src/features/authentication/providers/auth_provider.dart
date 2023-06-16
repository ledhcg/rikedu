import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:rikedu/src/features/timetable/models/group_model.dart';
import 'package:rikedu/src/utils/constants/api_constants.dart';
import 'package:rikedu/src/utils/constants/firebase_constants.dart';
import 'package:rikedu/src/utils/constants/roles_constants.dart';
import 'package:rikedu/src/utils/constants/storage_constants.dart';
import 'package:rikedu/src/utils/service/api_service.dart';
import 'package:rikedu/src/utils/service/firebase_service.dart';
import 'package:rikedu/src/utils/service/notification_service.dart';
import 'package:rikedu/src/utils/service/storage_service.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService _apiService = Get.find();
  final StorageService _storageService = Get.find();
  final NotificationService _notificationService = Get.find();
  final FirebaseService firebaseService = Get.find();

  bool _authenticated = false;
  bool _responseStatus = false;
  String _responseMessage = '';
  bool get isAuthenticated => _authenticated;
  bool get responseStatus => _responseStatus;
  String get responseMessage => _responseMessage;

  final Rx<User> _user = User.defaultUser().obs;
  final Rx<User> _student = User.defaultUser().obs;
  final Rx<User> _parent = User.defaultUser().obs;
  User get user => _user.value;
  User get student => _student.value;
  User get parent => _parent.value;

  final RxString _role = ''.obs;
  String get role => _role.value;

  final RxBool _studentIsActive = false.obs;
  bool get studentIsActive => _studentIsActive.value;

  Future<void> init() async {
    await checkIsAuthenticated();
    await getData();
  }

  // Future<void> listenStudentActive() async {
  //   Stream<DocumentSnapshot<Object?>> dataStream =
  //       await firebaseService.streamData(FirebaseConst.USER, student.id);
  //   dataStream.listen((snapshot) async {
  //     // Handle the received snapshot
  //     if (snapshot.exists) {
  //       Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
  //       _studentIsActive.value = data['isActive'];
  //     } else {
  //       // The document doesn't exist
  //     }
  //   }, onError: (error) {
  //     // Handle any errors that occur during streaming
  //   });
  // }

  Future<void> setStudentOnline() async {
    await firebaseService.setData(
      FirebaseConst.STUDENT_STATUS,
      student.id,
      {
        'isActive': true,
      },
      SetOptions(merge: true),
    );
    print("Student active: Online");
  }

  Future<void> setStudentOffline() async {
    await firebaseService.setData(
      FirebaseConst.STUDENT_STATUS,
      student.id,
      {
        'isActive': false,
      },
      SetOptions(merge: true),
    );
    print("Student active: Offline");
  }

  Future<void> getData() async {
    if (isAuthenticated) {
      _user.value = await getUser();
      _role.value = await getRole();

      if (role == RolesConst.PARENT) {
        _parent.value = user;
        _student.value = await getStudent();
      }
      if (role == RolesConst.STUDENT) {
        _student.value = user;
        _parent.value = await getParent();
        await setStudentOnline();
        // await listenStudentActive();
      }
    }
  }

  Future<String> getRole() async {
    return await _storageService.readData(StorageConst.USER_ROLE);
  }

  Future<void> checkIsAuthenticated() async {
    _authenticated = _storageService.hasData(StorageConst.USER_TOKEN);
  }

  Future<void> login(String emailUsername, String password) async {
    try {
      final response = await _apiService.post(ApiConst.LOGIN_ENDPOINT, {
        'email_username': emailUsername,
        'password': password,
      });

      if (response.body['success']) {
        _authenticated = true;
        await setUser(User.fromJson(response.body['data']['user']));
        await setData(response.body['data']);
        await getData();
        await setListenNotification();
        responseSuccess(response.body['message']);
        notifyListeners();
      } else {
        _authenticated = false;
        responseFail(response.body['message']);
        notifyListeners();
      }
    } catch (e) {
      responseFail(e.toString());
      notifyListeners();
      rethrow;
    }
  }

  Future<void> logout(String id) async {
    try {
      _storageService.clearData();
      _authenticated = false;
      _apiService.post(ApiConst.LOGOUT_ENDPOINT, {'id': id});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setListenNotification() async {
    try {
      _notificationService.getUserID();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setData(Map<String, dynamic> data) async {
    String userID = data['user']['id'];
    _storageService.writeData(StorageConst.USER_ID, userID);
    String userToken = data['authentication']['access_token'][0];
    _storageService.writeData(StorageConst.USER_TOKEN, userToken);
    String userRole = data['authorization']['role'][0];
    _storageService.writeData(StorageConst.USER_ROLE, userRole);

    if (userRole == RolesConst.PARENT) {
      User parent = User.fromJson(data['user']);
      User student = User.fromJson(data['student']);
      //Parent
      _storageService.writeData(
          StorageConst.PARENT_DATA, jsonEncode(parent.toJson()));
      _storageService.writeData(StorageConst.PARENT_ID, data['user']['id']);
      //Student
      _storageService.writeData(
          StorageConst.STUDENT_DATA, jsonEncode(student.toJson()));
      _storageService.writeData(StorageConst.STUDENT_ID, data['student']['id']);
    }

    if (userRole == RolesConst.STUDENT) {
      User parent = User.fromJson(data['parent']);
      User student = User.fromJson(data['user']);
      //Parent
      _storageService.writeData(
          StorageConst.PARENT_DATA, jsonEncode(parent.toJson()));
      _storageService.writeData(StorageConst.PARENT_ID, data['parent']['id']);
      //Student
      _storageService.writeData(
          StorageConst.STUDENT_DATA, jsonEncode(student.toJson()));
      _storageService.writeData(StorageConst.STUDENT_ID, data['user']['id']);
    }
    // Group
    Group group = Group.fromJson(data['group'][0]);
    _storageService.writeData(
        StorageConst.GROUP_DATA, jsonEncode(group.toJson()));
    _storageService.writeData(StorageConst.GROUP_ID, data['group'][0]['id']);
  }

  Future<void> setUser(User user) async {
    _storageService.writeData(
        StorageConst.USER_DATA, jsonEncode(user.toJson()));
  }

  Future<User> getUser() async {
    try {
      final userJson = await _storageService.readData(StorageConst.USER_DATA);
      return userJson != null
          ? User.fromJson(jsonDecode(userJson))
          : User.defaultUser();
    } catch (e) {
      rethrow;
    }
  }

  Future<User> getStudent() async {
    try {
      final studentJson =
          await _storageService.readData(StorageConst.STUDENT_DATA);
      return studentJson != null
          ? User.fromJson(jsonDecode(studentJson))
          : User.defaultUser();
    } catch (e) {
      rethrow;
    }
  }

  Future<User> getParent() async {
    try {
      final parentJson =
          await _storageService.readData(StorageConst.PARENT_DATA);
      return parentJson != null
          ? User.fromJson(jsonDecode(parentJson))
          : User.defaultUser();
    } catch (e) {
      rethrow;
    }
  }

  Future<User> updateUser() async {
    try {
      final parentJson =
          await _storageService.readData(StorageConst.PARENT_DATA);
      return parentJson != null
          ? User.fromJson(jsonDecode(parentJson))
          : User.defaultUser();
    } catch (e) {
      rethrow;
    }
  }

  void responseSuccess(String message) {
    _responseStatus = true;
    _responseMessage = message;
  }

  void responseFail(String message) {
    _responseStatus = false;
    _responseMessage = message;
  }
}
