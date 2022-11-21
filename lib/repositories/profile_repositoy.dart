import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/models.dart';
import '../constants/db_constants.dart';

class ProfileRepository {
  final FirebaseFirestore firebaseFirestore;

  ProfileRepository({required this.firebaseFirestore});

  Future<User> getProfile({required String uid}) async {
    try {
      final DocumentSnapshot userDoc = await usersRef.doc(uid).get();

      if (!userDoc.exists) {
        throw '404: User not found';
      }

      final User user = User.fromDoc(userDoc);
      return user;
    } on FirebaseException catch (err) {
      throw CustomError(
        code: err.code,
        message: err.message!,
        plugin: err.plugin,
      );
    } catch (err) {
      throw CustomError(
        code: 'Exception',
        message: err.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }
}
