import 'package:pocketbase/pocketbase.dart';

class User {
  final String id;
  final String username;
  final String name;
  final String created;
  final String updated;
  final String avatar;

  User({
    required this.username,
    required this.created,
    required this.updated,
    required this.avatar,
    required this.id,
    required this.name,
  });

  factory User.fromLocalDatabase(Map<String, dynamic> map) {
    return User(
      id: (map['id'] ?? '') as String,
      username: (map['username'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      created: (map['created'] ?? '') as String,
      updated: (map['updated'] ?? '') as String,
      avatar: (map['avatar'] ?? '') as String,
    );
  }

  factory User.fromNetwork(RecordModel record) {
    return User(
      id: record.id,
      username: record.getStringValue('username'),
      name: record.getStringValue('name'),
      created: record.getStringValue('created'),
      updated: record.getStringValue('updated'),
      avatar: record.getStringValue('avatar'),
    );
  }
}
