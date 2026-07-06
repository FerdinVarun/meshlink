import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _msgController = TextEditingController();

  List<Map<String, dynamic>> messages = [
    {"text": "Hey! Are you there?", "isMe": false},
    {"text": "Yes, I am connected.", "isMe": true},
  ];

  void sendMessage() {
    if (_msgController.text.trim().isEmpty) return;

    setState(() {
      messages.add({
        "text": _msgController.text,
        "isMe": true,
      });
    });

    _msgController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
      ),

      body: Column(
        children: [

          // CHAT LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return Align(
                  alignment: msg["isMe"]
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: msg["isMe"]
                          ? const Color(0xFF2563EB)
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      msg["text"],
                      style: TextStyle(
                        color: msg["isMe"] ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // INPUT BOX
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                )
              ],
            ),
            child: Row(
              children: [

                // TEXT FIELD
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    decoration: InputDecoration(
                      hintText: "Type message...",
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // SEND BUTTON
                GestureDetector(
                  onTap: sendMessage,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFF2563EB),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}