import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String profileImage;
  final int point;
  final String rank;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.point,
    required this.rank,
  });

  factory User.fromDoc(DocumentSnapshot userDoc) {
    final userData = userDoc.data() as Map<String, dynamic>?;

    return User(
      id: userDoc.id,
      name: userData!['name'] as String,
      email: userData['email'] as String,
      profileImage: userData['profileImage'] as String,
      point: userData['point'] as int,
      rank: userData['rank'] as String,
    );
  }

  factory User.initial() => const User(
        id: '',
        name: '',
        email: '',
        profileImage: '',
        point: -1,
        rank: '',
      );

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      profileImage,
      point,
      rank,
    ];
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, profileImage: $profileImage, point: $point, rank: $rank)';
  }
}
