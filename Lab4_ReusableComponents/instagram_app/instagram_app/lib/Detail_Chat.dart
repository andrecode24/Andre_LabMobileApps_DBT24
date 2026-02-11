import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        elevation: 0,
        title: const Text(
          'drenosaurus',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
            color: Colors.white,
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: const [
          ChatTile(
            username: 'apx gp',
            lastMessage: 'Seen by dif.',
            time: 'Now',
            isActive: false,
            messageCount: 1,
          ),
          ChatTile(
            username: 'juneejutsu',
            lastMessage: 'awokwowkwka',
            time: '1w',
            isActive: false,
            messageCount: 0,
            hasStory: true,
          ),
          ChatTile(
            username: 'kainoeh',
            lastMessage: 'Active 50m ago',
            time: 'Recently',
            isActive: true,
            messageCount: 0,
          ),
          ChatTile(
            username: 'miumiu.91687',
            lastMessage: 'demm',
            time: '2w',
            isActive: false,
            messageCount: 0,
          ),
          ChatTile(
            username: 'palyyaa',
            lastMessage: 'MAKAASIHH DREEE!!',
            time: '2w',
            isActive: false,
            messageCount: 0,
          ),
          ChatTile(
            username: 'another.diff',
            lastMessage: '😭😭',
            time: '3w',
            isActive: false,
            messageCount: 0,
          ),
          ChatTile(
            username: 'leseehaan',
            lastMessage: 'tenkyuu dreee',
            time: '4w',
            isActive: true,
            messageCount: 0,
            hasStory: true,
            hasNotification: true,
          ),
          ChatTile(
            username: 'arjaii',
            lastMessage: 'Seen',
            time: 'Yesterday',
            isActive: false,
            messageCount: 0,
          ),
          ChatTile(
            username: 'keiyyoooo',
            lastMessage: 'Sent',
            time: 'Yesterday',
            isActive: false,
            messageCount: 0,
          ),
          ChatTile(
            username: 'adhifaryasatya',
            lastMessage: 'Seen',
            time: '2 days ago',
            isActive: false,
            messageCount: 0,
          ),
        ],
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final String username;
  final String lastMessage;
  final String time;
  final bool isActive;
  final int messageCount;
  final bool hasStory;
  final bool hasNotification;

  const ChatTile({
    Key? key,
    required this.username,
    required this.lastMessage,
    required this.time,
    required this.isActive,
    required this.messageCount,
    this.hasStory = false,
    this.hasNotification = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConversationScreen(username: username),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            // Avatar with gradient ring and story indicator
            Stack(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: hasStory
                        ? const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xFFF58529),
                              Color(0xFFDD2A7B),
                              Color(0xFF8134AF),
                            ],
                          )
                        : null,
                    border: hasStory
                        ? Border.all(
                            color: Colors.transparent,
                            width: 2,
                          )
                        : null,
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1a1a1a),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        'https://i.pravatar.cc/150?img=${username.hashCode % 70}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[800],
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 28,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                // Active status indicator
                if (isActive)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF31A24C),
                        border: Border.all(
                          color: const Color(0xFF000000),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            // Chat info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                          color: Color(0xFF737373),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          lastMessage,
                          style: TextStyle(
                            color: const Color(0xFF737373),
                            fontSize: 13,
                            fontWeight:
                                messageCount > 0 ? FontWeight.w600 : FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (messageCount > 0)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0095F6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            messageCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Camera icon and notification
            Stack(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                if (hasNotification)
                  Positioned(
                    top: -4,
                    right: -4,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0095F6),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Conversation Screen
class ConversationScreen extends StatefulWidget {
  final String username;

  const ConversationScreen({Key? key, required this.username})
      : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

// Unique messages for each conversation
class ConversationData {
  static final Map<String, List<Map<String, dynamic>>> messages = {
    'apx gp': [
      {
        'text': 'Hey! Check out this cool photo',
        'isOwn': false,
        'timestamp': '10:30 AM',
        'status': 'seen',
      },
      {
        'text': 'Looks amazing! 🔥',
        'isOwn': true,
        'timestamp': '10:32 AM',
        'status': 'seen',
      },
      {
        'text': 'Right? Let\'s hang out soon',
        'isOwn': false,
        'timestamp': '10:35 AM',
        'status': 'seen',
      },
    ],
    'juneejutsu': [
      {
        'text': 'OMG did you see the concert?',
        'isOwn': false,
        'timestamp': '2:15 PM',
        'status': 'seen',
      },
      {
        'text': 'Not yet! How was it?',
        'isOwn': true,
        'timestamp': '2:20 PM',
        'status': 'seen',
      },
      {
        'text': 'It was absolutely insane! 🎶',
        'isOwn': false,
        'timestamp': '2:25 PM',
        'status': 'seen',
      },
      {
        'text': 'We should go to the next one together',
        'isOwn': false,
        'timestamp': '2:26 PM',
        'status': 'seen',
      },
    ],
    'kainoeh': [
      {
        'text': 'Working on that project?',
        'isOwn': false,
        'timestamp': '3:45 PM',
        'status': 'seen',
      },
      {
        'text': 'Yeah almost done with it',
        'isOwn': true,
        'timestamp': '3:50 PM',
        'status': 'seen',
      },
      {
        'text': 'Nice! Wanna review it together?',
        'isOwn': false,
        'timestamp': '3:52 PM',
        'status': 'seen',
      },
    ],
    'miumiu.91687': [
      {
        'text': 'Did you finish your assignments?',
        'isOwn': false,
        'timestamp': 'Yesterday',
        'status': 'seen',
      },
      {
        'text': 'Almost! Just need to submit',
        'isOwn': true,
        'timestamp': 'Yesterday',
        'status': 'seen',
      },
      {
        'text': 'Same here lol 😅',
        'isOwn': false,
        'timestamp': 'Yesterday',
        'status': 'seen',
      },
    ],
    'palyyaa': [
      {
        'text': 'THANK YOU SO MUCH FOR HELPING! 🙏',
        'isOwn': false,
        'timestamp': '5:10 PM',
        'status': 'seen',
      },
      {
        'text': 'Anytime! That\'s what friends are for',
        'isOwn': true,
        'timestamp': '5:15 PM',
        'status': 'seen',
      },
      {
        'text': 'You\'re the best! ❤️',
        'isOwn': false,
        'timestamp': '5:16 PM',
        'status': 'seen',
      },
    ],
    'another.diff': [
      {
        'text': 'HAHAHAHA 😭😭',
        'isOwn': false,
        'timestamp': '11:20 AM',
        'status': 'seen',
      },
      {
        'text': 'That was so funny lol',
        'isOwn': true,
        'timestamp': '11:22 AM',
        'status': 'seen',
      },
      {
        'text': 'I can\'t stop laughing 😂😂😂',
        'isOwn': false,
        'timestamp': '11:25 AM',
        'status': 'seen',
      },
    ],
    'leseehaan': [
      {
        'text': 'How\'s your day going?',
        'isOwn': false,
        'timestamp': '9:30 AM',
        'status': 'seen',
      },
      {
        'text': 'Pretty good! Just working on some stuff',
        'isOwn': true,
        'timestamp': '9:35 AM',
        'status': 'seen',
      },
      {
        'text': 'Awesome! Let me know if you need anything',
        'isOwn': false,
        'timestamp': '9:40 AM',
        'status': 'seen',
      },
      {
        'text': 'Thanks so much! 💙',
        'isOwn': true,
        'timestamp': '9:42 AM',
        'status': 'seen',
      },
    ],
    'arjaii': [
      {
        'text': 'Remember that time we went hiking?',
        'isOwn': false,
        'timestamp': '4:15 PM',
        'status': 'seen',
      },
      {
        'text': 'Haha yes! That was so fun',
        'isOwn': true,
        'timestamp': '4:20 PM',
        'status': 'seen',
      },
      {
        'text': 'We should go again sometime',
        'isOwn': false,
        'timestamp': '4:22 PM',
        'status': 'seen',
      },
    ],
    'keiyyoooo': [
      {
        'text': 'Yo what\'s up?',
        'isOwn': false,
        'timestamp': '8:00 PM',
        'status': 'sent',
      },
      {
        'text': 'Hey! Just chilling',
        'isOwn': true,
        'timestamp': '8:05 PM',
        'status': 'sent',
      },
    ],
    'adhifaryasatya': [
      {
        'text': 'Happy birthday! 🎉🎂',
        'isOwn': false,
        'timestamp': '12:00 AM',
        'status': 'seen',
      },
      {
        'text': 'Thank you so much!! 🥳',
        'isOwn': true,
        'timestamp': '12:05 AM',
        'status': 'seen',
      },
      {
        'text': 'We\'re throwing you a party this weekend!',
        'isOwn': false,
        'timestamp': '12:10 AM',
        'status': 'seen',
      },
    ],
  };

  static List<Map<String, dynamic>> getMessagesForUser(String username) {
    return List.from(messages[username] ?? [
      {
        'text': 'Hey there!',
        'isOwn': false,
        'timestamp': '10:30 AM',
        'status': 'seen',
      },
      {
        'text': 'Hi! How are you?',
        'isOwn': true,
        'timestamp': '10:32 AM',
        'status': 'seen',
      },
    ]);
  }
}

class _ConversationScreenState extends State<ConversationScreen> {
  final TextEditingController _messageController = TextEditingController();
  late List<Map<String, dynamic>> messages;

  @override
  void initState() {
    super.initState();
    // Get unique messages for this user
    messages = ConversationData.getMessagesForUser(widget.username);
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.add({
          'text': _messageController.text,
          'isOwn': true,
          'timestamp': 'now',
          'status': 'sent',
        });
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.network(
                  'https://i.pravatar.cc/150?img=${widget.username.hashCode % 70}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[800],
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 20,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  'Active 2h ago',
                  style: TextStyle(
                    color: Color(0xFF737373),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
            color: const Color(0xFF0095F6),
          ),
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {},
            color: const Color(0xFF0095F6),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {},
            color: Colors.white,
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[messages.length - 1 - index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment: message['isOwn']
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      if (!message['isOwn']) const SizedBox(width: 4),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: message['isOwn']
                              ? const Color(0xFF262626)
                              : const Color(0xFF262626),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          message['text'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      if (message['isOwn']) const SizedBox(width: 4),
                    ],
                  ),
                );
              },
            ),
          ),
          // Message input field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: const Color(0xFF262626),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.add_circle_outline,
                    color: const Color(0xFF0095F6),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF262626),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _messageController,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Aa',
                        hintStyle: const TextStyle(
                          color: Color(0xFF737373),
                          fontSize: 15,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _sendMessage,
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
