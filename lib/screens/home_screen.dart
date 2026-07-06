import 'package:flutter/material.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MeshLink"),
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Greeting
              const Text(
                "Hello 👋",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 5),

              const Text(
                "Offline Mesh Network Active",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 20),

              // STATUS CARD
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2563EB), Color(0xFF1E40AF)],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.wifi, color: Colors.white, size: 40),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mesh Status",
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          "ACTIVE",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Nearby Devices
              const Text(
                "Nearby Devices",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              _deviceTile("Alice", true, context),
              _deviceTile("Bob", true, context),
              _deviceTile("Charlie", false, context),

              const SizedBox(height: 25),

              // Recent Chats
              const Text(
                "Recent Chats",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              _chatTile("Alice"),
              _chatTile("Bob"),

              const SizedBox(height: 30),

              // SOS BUTTON
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Text(
                    "🚨 SOS EMERGENCY",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // DEVICE TILE
  Widget _deviceTile(String name, bool online, BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.circle,
        color: online ? Colors.green : Colors.grey,
      ),
      title: Text(name),
      subtitle: Text(online ? "Online" : "Offline"),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ChatScreen(),
          ),
        );
      },
    );
  }

  // CHAT TILE
  Widget _chatTile(String name) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text(name),
      subtitle: const Text("Tap to open chat"),
    );
  }
}