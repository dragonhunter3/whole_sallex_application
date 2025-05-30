import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String chatRoomId;
  final String currentUserEmail;

  ChatScreen({required this.chatRoomId, required this.currentUserEmail});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  Stream<List<Map<String, dynamic>>> getMessages() {
    return FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(widget.chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<void> sendMessage() async {
    final messageText = _controller.text.trim();
    if (messageText.isEmpty) return;

    final messagesRef = FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(widget.chatRoomId)
        .collection('messages');

    await messagesRef.add({
      'sender': widget.currentUserEmail,
      'text': messageText,
      'timestamp': FieldValue.serverTimestamp(),
    });

    await FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(widget.chatRoomId)
        .update({
      'lastMessage': messageText,
      'lastMessageTime': FieldValue.serverTimestamp(),
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: getMessages(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());

                final messages = snapshot.data!;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isMe = msg['sender'] == widget.currentUserEmail;
                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blue[200] : Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(msg['text']),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(child: TextField(controller: _controller)),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
