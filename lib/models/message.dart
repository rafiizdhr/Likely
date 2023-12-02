part of 'models.dart';

class Message {
  final String senderId;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.timestamp,
    required this.message,
  });

  //convert to a map
  Map<String, dynamic> toMap() {
    return {
      "senderId" : senderId,
      "receiverId" : receiverId,
      "message" : message,
      "timestamp" : timestamp,
    };
  }
}