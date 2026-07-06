import 'package:nearby_connections/nearby_connections.dart';
import 'dart:typed_data';
class MeshService {
  final Strategy strategy = Strategy.P2P_STAR;

  String userName = "User";

  /// Start advertising (make this device visible)
  Future<void> startAdvertising() async {
    try {
      await Nearby().startAdvertising(
        userName,
        strategy,
        onConnectionInitiated: (id, info) {
          Nearby().acceptConnection(
            id,
            onPayLoadRecieved: (endid, payload) {
              print("Message received: ${payload.bytes}");
            },
          );
        },
        onConnectionResult: (id, status) {
          print("Connection result: $status");
        },
        onDisconnected: (id) {
          print("Disconnected: $id");
        },
      );
    } catch (e) {
      print("Advertising error: $e");
    }
  }

  /// Start discovering nearby devices
  Future<List<String>> discoverDevices() async {
    List<String> devices = [];

    try {
      await Nearby().startDiscovery(
        userName,
        strategy,
        onEndpointFound: (id, name, serviceId) {
          print("Found device: $name");

          devices.add(name);

          // Auto request connection (optional)
          Nearby().requestConnection(
            userName,
            id,
            onConnectionInitiated: (id, info) {
              Nearby().acceptConnection(
                id,
                onPayLoadRecieved: (endid, payload) {
                  print("Received: ${payload.bytes}");
                },
              );
            },
            onConnectionResult: (id, status) {
              print("Status: $status");
            },
            onDisconnected: (id) {},
          );
        },
        onEndpointLost: (id) {
          print("Device lost: $id");
        },
      );
    } catch (e) {
      print("Discovery error: $e");
    }

    return devices;
  }

  /// Send message to connected device
  Future<void> sendMessage(String endpointId, String message) async {
    try {
      await Nearby().sendBytesPayload(
        endpointId,
        Uint8List.fromList(message.codeUnits),
      );
    } catch (e) {
      print("Send error: $e");
    }
  }

  /// Stop all connections
  Future<void> stopAll() async {
    await Nearby().stopAllEndpoints();
  }
}