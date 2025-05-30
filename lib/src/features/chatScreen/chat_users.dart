import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whole_selle_x_application/src/features/chatScreen/chat_screen.dart';
import 'package:whole_selle_x_application/src/features/chatScreen/chatscreen.dart';

class UsersScreen extends StatefulWidget {
  final String currentUserEmail;

  const UsersScreen({required this.currentUserEmail, Key? key})
      : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  DocumentSnapshot? currentUser;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final query = await FirebaseFirestore.instance.collection('users').get();

      final allUsers = query.docs;

      // Case-insensitive email comparison with trim
      final current = allUsers.firstWhere(
        (doc) =>
            (doc['userEmail'] as String?)?.trim().toLowerCase() ==
            widget.currentUserEmail.trim().toLowerCase(),
      );

      setState(() {
        currentUser = current;
        isLoading = false;
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = e.toString();
      });
      debugPrint('Error fetching users: $e');
    }
  }

  void openChat(DocumentSnapshot customer) async {
    try {
      final customerEmail = customer['userEmail'] as String;
      final currentEmail = currentUser?['userEmail'] as String;

      if (currentEmail.isEmpty || customerEmail.isEmpty) {
        throw Exception('Emails cannot be empty');
      }

      final chatRoomId = getChatRoomId(currentEmail, customerEmail);

      final chatRoomRef =
          FirebaseFirestore.instance.collection('chatRooms').doc(chatRoomId);

      final chatRoomSnapshot = await chatRoomRef.get();

      if (!chatRoomSnapshot.exists) {
        await chatRoomRef.set({
          'users': [currentEmail, customerEmail],
          'userIds': [currentUser?.id, customer.id], // Store document IDs too
          'createdAt': FieldValue.serverTimestamp(),
          'lastMessage': '',
          'lastMessageTime': FieldValue.serverTimestamp(),
        });
      }

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChatScreen(
            chatRoomId: chatRoomId,
            currentUserEmail: currentEmail,
            // recipientName: customer['userName'] as String? ?? 'Customer',
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error opening chat: ${e.toString()}')),
      );
    }
  }

  String getChatRoomId(String user1, String user2) {
    return (user1.compareTo(user2) < 0) ? '$user1\_$user2' : '$user2\_$user1';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Customers")),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $errorMessage'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchUsers,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (currentUser == null) {
      return const Center(child: Text('Current user not found'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final users = snapshot.data!.docs.where((doc) {
          final email = doc['userEmail'] as String?;
          return email != null &&
              email.trim().toLowerCase() !=
                  widget.currentUserEmail.trim().toLowerCase();
        }).toList();

        if (users.isEmpty) {
          return const Center(child: Text('No other users found'));
        }

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  user['profilePicture'] as String? ?? '',
                ),
                child: (user['profilePicture'] as String?)?.isEmpty ?? true
                    ? Text(user['userName'][0].toUpperCase())
                    : null,
              ),
              title: Text(user['userName'] as String? ?? 'No name'),
              subtitle: Text(user['userEmail'] as String? ?? 'No email'),
              onTap: () => openChat(user),
            );
          },
        );
      },
    );
  }
}
