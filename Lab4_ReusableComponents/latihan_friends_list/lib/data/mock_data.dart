import '../models/user_model.dart';
import '../models/message_model.dart';

class MockData {
  // Mock contacts list
  static List<UserModel> getContacts() {
    return [
      UserModel(
        id: '1',
        name: 'Hajeera',
        profileImage: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&h=150&fit=crop',
        isOnline: true,
        lastMessage: 'Ok, let me check',
        timestamp: '9:42am',
        lastMessageTime: DateTime.now().subtract(Duration(minutes: 18)),
      ),
      UserModel(
        id: '2',
        name: 'Riya',
        profileImage: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop',
        isOnline: true,
        lastMessage: 'See you tomorrow',
        timestamp: 'Yesterday',
        lastMessageTime: DateTime.now().subtract(Duration(days: 1)),
      ),
      UserModel(
        id: '3',
        name: 'Nakul',
        profileImage: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop',
        isOnline: true,
        lastMessage: 'Ok',
        timestamp: 'Monday',
        lastMessageTime: DateTime.now().subtract(Duration(days: 2)),
      ),
      UserModel(
        id: '4',
        name: 'Khan',
        profileImage: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop',
        isOnline: false,
        lastMessage: 'Check the documents',
        timestamp: 'Monday',
        lastMessageTime: DateTime.now().subtract(Duration(days: 2)),
      ),
      UserModel(
        id: '5',
        name: 'Diya',
        profileImage: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop',
        isOnline: true,
        lastMessage: 'Good morning',
        timestamp: 'Sunday',
        lastMessageTime: DateTime.now().subtract(Duration(days: 3)),
      ),
      UserModel(
        id: '6',
        name: 'Sahana',
        profileImage: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&h=150&fit=crop',
        isOnline: false,
        lastMessage: 'Thank you',
        timestamp: 'Sunday',
        lastMessageTime: DateTime.now().subtract(Duration(days: 3)),
      ),
    ];
  }

  // Mock messages for a specific chat
  static List<MessageModel> getMessages(String contactId) {
    switch (contactId) {
      case '1':
        // Messages with Hajeera
        return [
          MessageModel(
            id: '1',
            senderId: 'me',
            receiverId: '1',
            message: 'Hi, Hajeera',
            timestamp: DateTime.now().subtract(Duration(minutes: 30)),
            isMe: true,
          ),
          MessageModel(
            id: '2',
            senderId: 'me',
            receiverId: '1',
            message: 'Are you available for a UI work?',
            timestamp: DateTime.now().subtract(Duration(minutes: 29)),
            isMe: true,
          ),
          MessageModel(
            id: '3',
            senderId: 'me',
            receiverId: '1',
            message: 'If you are interested, let me know',
            timestamp: DateTime.now().subtract(Duration(minutes: 28)),
            isMe: true,
          ),
          MessageModel(
            id: '4',
            senderId: '1',
            receiverId: 'me',
            message: 'Hey, I\'m open for work, plz share me further details.',
            timestamp: DateTime.now().subtract(Duration(minutes: 25)),
            isMe: false,
          ),
          MessageModel(
            id: '5',
            senderId: 'me',
            receiverId: '1',
            message: 'Sure I\'ll share you!',
            timestamp: DateTime.now().subtract(Duration(minutes: 22)),
            isMe: true,
          ),
          MessageModel(
            id: '6',
            senderId: 'me',
            receiverId: '1',
            message: 'www.dribbble.com/fbdib/af',
            timestamp: DateTime.now().subtract(Duration(minutes: 20)),
            isMe: true,
          ),
          MessageModel(
            id: '7',
            senderId: 'me',
            receiverId: '1',
            message: 'Hey i have shared you the link',
            timestamp: DateTime.now().subtract(Duration(minutes: 19)),
            isMe: true,
          ),
          MessageModel(
            id: '8',
            senderId: '1',
            receiverId: 'me',
            message: 'Ok, let me check',
            timestamp: DateTime.now().subtract(Duration(minutes: 18)),
            isMe: false,
          ),
        ];

      case '2':
        // Messages with Riya
        return [
          MessageModel(
            id: '1',
            senderId: 'me',
            receiverId: '2',
            message: 'Hey Riya, how are you?',
            timestamp: DateTime.now().subtract(Duration(days: 1, hours: 2)),
            isMe: true,
          ),
          MessageModel(
            id: '2',
            senderId: '2',
            receiverId: 'me',
            message: 'I\'m good! Thanks for asking',
            timestamp: DateTime.now().subtract(Duration(days: 1, hours: 1)),
            isMe: false,
          ),
          MessageModel(
            id: '3',
            senderId: 'me',
            receiverId: '2',
            message: 'Are we still on for tomorrow?',
            timestamp: DateTime.now().subtract(Duration(days: 1, hours: 1)),
            isMe: true,
          ),
          MessageModel(
            id: '4',
            senderId: '2',
            receiverId: 'me',
            message: 'See you tomorrow',
            timestamp: DateTime.now().subtract(Duration(days: 1)),
            isMe: false,
          ),
        ];

      case '3':
        // Messages with Nakul
        return [
          MessageModel(
            id: '1',
            senderId: 'me',
            receiverId: '3',
            message: 'Nakul, did you finish the project?',
            timestamp: DateTime.now().subtract(Duration(days: 2, hours: 3)),
            isMe: true,
          ),
          MessageModel(
            id: '2',
            senderId: '3',
            receiverId: 'me',
            message: 'Ok',
            timestamp: DateTime.now().subtract(Duration(days: 2)),
            isMe: false,
          ),
        ];

      case '4':
        // Messages with Khan
        return [
          MessageModel(
            id: '1',
            senderId: 'me',
            receiverId: '4',
            message: 'Hi Khan, I sent you the files',
            timestamp: DateTime.now().subtract(Duration(days: 2, hours: 5)),
            isMe: true,
          ),
          MessageModel(
            id: '2',
            senderId: '4',
            receiverId: 'me',
            message: 'Thanks! Let me review them',
            timestamp: DateTime.now().subtract(Duration(days: 2, hours: 4)),
            isMe: false,
          ),
          MessageModel(
            id: '3',
            senderId: '4',
            receiverId: 'me',
            message: 'Check the documents',
            timestamp: DateTime.now().subtract(Duration(days: 2)),
            isMe: false,
          ),
        ];

      case '5':
        // Messages with Diya
        return [
          MessageModel(
            id: '1',
            senderId: '5',
            receiverId: 'me',
            message: 'Good morning',
            timestamp: DateTime.now().subtract(Duration(days: 3)),
            isMe: false,
          ),
          MessageModel(
            id: '2',
            senderId: 'me',
            receiverId: '5',
            message: 'Good morning! How\'s everything?',
            timestamp: DateTime.now().subtract(Duration(days: 3)),
            isMe: true,
          ),
        ];

      case '6':
        // Messages with Sahana
        return [
          MessageModel(
            id: '1',
            senderId: 'me',
            receiverId: '6',
            message: 'Here\'s the information you requested',
            timestamp: DateTime.now().subtract(Duration(days: 3, hours: 2)),
            isMe: true,
          ),
          MessageModel(
            id: '2',
            senderId: '6',
            receiverId: 'me',
            message: 'Thank you',
            timestamp: DateTime.now().subtract(Duration(days: 3)),
            isMe: false,
          ),
        ];

      default:
        // Empty messages for unknown contacts
        return [];
    }
  }
}