import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class FirebaseService extends GetxService {
  static FirebaseService get to => Get.find();

  FirebaseFirestore? _firestore;

  Future<FirebaseService> init() async {
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
    return this;
  }

  // Future<DocumentSnapshot<Map<String, dynamic>>> getData(String documentPath) {
  //   return _firestore!.doc(documentPath).get();
  // }

  // Future<void> setData(String documentPath, Map<String, dynamic> data) {
  //   return _firestore!.doc(documentPath).set(data);
  // }

  // Future<void> updateData(String documentPath, Map<String, dynamic> data) {
  //   return _firestore!.doc(documentPath).update(data);
  // }

  // Stream<DocumentSnapshot<Map<String, dynamic>>> streamData(
  //     String documentPath) {
  //   return _firestore!.doc(documentPath).snapshots();
  // }

  // Phương thức lấy dữ liệu từ Firestore
  Future<DocumentSnapshot> getData(String collection, String documentId) async {
    return _firestore!.collection(collection).doc(documentId).get();
  }

  // Phương thức lưu dữ liệu vào Firestore
  Future<void> setData(
      String collection, String documentId, Map<String, dynamic> data,
      [SetOptions? options]) async {
    return _firestore!
        .collection(collection)
        .doc(documentId)
        .set(data, options);
  }

  // Phương thức cập nhật dữ liệu trong Firestore
  Future<void> updateData(
      String collection, String documentId, Map<String, dynamic> data) async {
    return _firestore!.collection(collection).doc(documentId).update(data);
  }

  // Phương thức lắng nghe dữ liệu realtime từ Firestore
  Future<Stream<DocumentSnapshot<Object?>>> streamData(
      String collection, String documentId) async {
    return _firestore!.collection(collection).doc(documentId).snapshots();
  }
}
