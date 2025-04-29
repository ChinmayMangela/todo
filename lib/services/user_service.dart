import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/utils/helper_functions.dart';

import '../features/authentication/domain/models/end_user.dart';

class UserService {
  final _firebaseFireStore = FirebaseFirestore.instance;

  Future<void> saveUser({required EndUser endUser, required String id}) async {
    try {
      _firebaseFireStore.collection('users').doc(id).set(
        endUser.toJson(),
      );
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }
}