import 'package:flutter/material.dart';
import 'chat_screen.dart';
import '../services/mesh_service.dart';

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

  void startMesh() async {
    setState(() {
      scanning = true;
    });

    // Start advertising (make your phone visible)
    meshService.startAdvertising();

    // Start discovering devices
    List<String> found = await meshService.discoverDevices();

    setState(() {
      devices = found;
      scanning = false;
    });
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            scanning
                ? const Center(child: CircularProgressIndicator())
                : devices.isEmpty
                    ? const Text("No devices found")
                    : Expanded(
                        child: ListView.builder(
                          itemCount: devices.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: const Icon(
                                Icons.circle,
                                color: Colors.green,
                              ),
                              title: Text(devices[index]),
                              subtitle: const Text("Tap to connect"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const ChatScreen(),
                                  ),
                                );
                              },
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