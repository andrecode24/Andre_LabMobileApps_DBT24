import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../widgets/contact_card.dart';
import 'chat_screen.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contacts = MockData.getContacts();

    return Scaffold(
      backgroundColor: Color(0xFF121212), // Spotify dark background
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar with gradient
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              backgroundColor: Color(0xFF121212),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF1DB954), // Spotify green
                        Color(0xFF1ED760),
                        Color(0xFF121212),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xFF282828),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(
                                Icons.settings_outlined,
                                color: Colors.white,
                                size: 28,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Good Morning',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Contacts list
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final contact = contacts[index];
                    return ContactCard(
                      contact: contact,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              contact: contact,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  childCount: contacts.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}