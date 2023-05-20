import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/timetable/models/group_model.dart';
import 'package:rikedu/src/features/timetable/models/timetable_modal.dart';
import 'package:rikedu/src/utils/constants/api_constants.dart';
import 'package:rikedu/src/utils/constants/storage_constants.dart';
import 'package:rikedu/src/utils/service/api_service.dart';
import 'package:rikedu/src/utils/service/storage_service.dart';

class TimetableProvider extends ChangeNotifier {
  final ApiService _apiService = Get.find();
  final StorageService _storageService = Get.find();

  final Rx<Timetable> _timetable = Timetable.defaultTimetable().obs;

  final RxBool _isExist = false.obs;
  final RxBool _responseStatus = false.obs;
  final RxString _responseMessage = ''.obs;
  final RxString _groupID = ''.obs;
  bool get isExist => _isExist.value;
  bool get responseStatus => _responseStatus.value;
  String get responseMessage => _responseMessage.value;
  String get groupID => _groupID.value;

  Timetable get timetable => _timetable.value;

  Future<void> init() async {
    await checkExistTimetable();
    if (!isExist) {
      await getGroupID();
      if (groupID != '') {
        await fetchData();
      }
    } else {
      await getTimetable();
    }
  }

  Future<void> getGroupID() async {
    if (await checkExistGroup()) {
      final groupJson = await _storageService.readData(StorageConst.GROUP_DATA);
      final group = Group.fromJson(jsonDecode(groupJson));
      _groupID.value = group != null ? group.id : "";
    }
  }

  Future<bool> checkExistGroup() async {
    return _storageService.hasData(StorageConst.GROUP_DATA);
  }

  Future<void> checkExistTimetable() async {
    _isExist.value = _storageService.hasData(StorageConst.TIMETABLE_DATA);
  }

  Future<void> fetchData() async {
    try {
      final response =
          await _apiService.get("${ApiConst.TIMETABLE_ENDPOINT}/$groupID");
      if (response.body['success']) {
        await setTimetable(Timetable.fromJson(response.body['data']));
        await getTimetable();
        responseSuccess(response.body['message']);
        notifyListeners();
      } else {
        responseFail(response.body['message']);
        notifyListeners();
      }
    } catch (e) {
      responseFail(e.toString());
      notifyListeners();
      rethrow;
    }
  }

  Future<void> getTimetable() async {
    try {
      final timetableJson =
          await _storageService.readData(StorageConst.TIMETABLE_DATA);
      _timetable.value = timetableJson != null
          ? Timetable.fromJson(jsonDecode(timetableJson))
          : timetable;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setTimetable(Timetable timetable) async {
    _storageService.writeData(
        StorageConst.TIMETABLE_DATA, jsonEncode(timetable.toJson()));
    checkExistTimetable();
  }

  void responseSuccess(String message) {
    _responseStatus.value = true;
    _responseMessage.value = message;
  }

  void responseFail(String message) {
    _responseStatus.value = false;
    _responseMessage.value = message;
  }
}
