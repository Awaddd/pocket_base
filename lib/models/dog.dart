import 'package:pocketbase/pocketbase.dart';

class Dog {
  final String id;
  final String name;

  Dog({required this.id, required this.name});

  factory Dog.fromLocalDatabase(Map<String, dynamic> map) {
    return Dog(
      id: (map['id'] ?? '') as String,
      name: (map['name'] ?? '') as String,
    );
  }

  factory Dog.fromNetwork(RecordModel record) {
    return Dog(
      id: record.id,
      name: record.getStringValue('name'),
    );
  }
}
