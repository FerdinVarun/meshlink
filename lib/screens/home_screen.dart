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
      body: Column(
        children: [
          const SizedBox(height: 20),

          const Text(
            "Nearby Devices",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          ListTile(
            leading: const Icon(Icons.circle, color: Colors.green),
            title: const Text("Device A"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChatScreen(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.circle, color: Colors.green),
            title: const Text("Device B"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChatScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}