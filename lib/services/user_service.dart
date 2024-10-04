import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/utils/helper_functions.dart';

class UserService {
  final _firebaseFireStore = FirebaseFirestore.instance;

  Future<void> addUser({required String email}) async {
    try {
      _firebaseFireStore.collection('users').add({
        'email': email,
      });
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }
}