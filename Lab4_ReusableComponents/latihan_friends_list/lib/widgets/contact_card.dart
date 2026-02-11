import 'package:flutter/material.dart';
import '../models/user_model.dart';

class ContactCard extends StatelessWidget {
  final UserModel contact;
  final VoidCallback onTap;

  const ContactCard({
    Key? key,
    required this.contact,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Color(0xFF1DB954).withOpacity(0.1),
      highlightColor: Color(0xFF1DB954).withOpacity(0.05),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            // Profile Image with online indicator
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF1DB954).withOpacity(
                          contact.isOnline ? 0.3 : 0,
                        ),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(contact.profileImage),
                  ),
                ),
                if (contact.isOnline)
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Color(0xFF1DB954), // Spotify green
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFF121212),
                          width: 2.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 16),
            // Name and last message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    contact.lastMessage,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFB3B3B3),
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            // Timestamp
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  contact.timestamp,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF535353),
                    fontWeight: FontWeight.w500,
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