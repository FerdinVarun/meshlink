import 'package:flutter/material.dart';

import '../services/mesh_service.dart';
import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MeshService meshService = MeshService();

  List<String> devices = [];
  bool scanning = false;

  @override
  void initState() {
    super.initState();
    startMesh();
  }

  Future<void> startMesh() async {
    setState(() {
      scanning = true;
    });

    // Request permissions ONLY ONCE
    await meshService.requestPermissions();

    // Wait for Android to finish granting permissions
    await Future.delayed(const Duration(milliseconds: 500));

    // Start advertising
    await meshService.startAdvertising();

    // Give Nearby API time to initialize
    await Future.delayed(const Duration(seconds: 1));

    // Start discovery
    List<String> found = await meshService.discoverDevices();

    if (!mounted) return;

    setState(() {
      devices = found;
      scanning = false;
    });
  }

  @override
  void dispose() {
    meshService.stopAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MeshLink"),
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Nearby Devices",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            if (scanning)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (devices.isEmpty)
              const Center(
                child: Text(
                  "Searching for nearby devices...",
                  style: TextStyle(fontSize: 16),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(
                          Icons.phone_android,
                          color: Colors.green,
                        ),
                        title: Text(devices[index]),
                        subtitle: const Text("Tap to chat"),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ChatScreen(),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}