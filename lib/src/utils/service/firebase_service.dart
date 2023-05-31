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

  Future<DocumentSnapshot> getData(String collection, String documentId) async {
    return _firestore!.collection(collection).doc(documentId).get();
  }

  Future<void> setData(
      String collection, String documentId, Map<String, dynamic> data,
      [SetOptions? options]) async {
    return _firestore!
        .collection(collection)
        .doc(documentId)
        .set(data, options);
  }

  Future<void> updateData(
      String collection, String documentId, Map<String, dynamic> data) async {
    return _firestore!.collection(collection).doc(documentId).update(data);
  }

  Future<Stream<DocumentSnapshot<Object?>>> streamData(
      String collection, String documentId) async {
    return _firestore!.collection(collection).doc(documentId).snapshots();
  }
}
