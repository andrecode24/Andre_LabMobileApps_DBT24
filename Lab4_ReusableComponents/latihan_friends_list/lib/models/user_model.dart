class UserModel {
  final String id;
  final String name;
  final String profileImage;
  final bool isOnline;
  final String lastMessage;
  final String timestamp;
  final DateTime lastMessageTime;

  UserModel({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.isOnline,
    required this.lastMessage,
    required this.timestamp,
    required this.lastMessageTime,
  });
}