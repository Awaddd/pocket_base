import 'package:pocketbase/pocketbase.dart';

class Message {
  final String id;
  final String userID;
  final String recipientID;
  final String text;

  Message({
    required this.id,
    required this.userID,
    required this.recipientID,
    required this.text,
  });

  factory Message.fromNetwork(RecordModel record) {
    return Message(
      id: record.id,
      userID: record.getStringValue('userID'),
      recipientID: record.getStringValue('recipientID'),
      text: record.getStringValue('text'),
    );
  }
}
