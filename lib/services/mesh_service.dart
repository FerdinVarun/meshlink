import 'dart:typed_data';

import 'package:nearby_connections/nearby_connections.dart';
import 'package:permission_handler/permission_handler.dart';

class MeshService {
  final Strategy strategy = Strategy.P2P_STAR;

  String userName = "User";

  /// Request all permissions at once
  Future<void> requestPermissions() async {
    await [
      Permission.location,
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetoothAdvertise,
      Permission.nearbyWifiDevices,
    ].request();
  }

  /// Start advertising
  Future<void> startAdvertising() async {
    try {
      await Nearby().startAdvertising(
        userName,
        strategy,
        onConnectionInitiated: (id, info) {
          print("Connection initiated: $id");

          Nearby().acceptConnection(
            id,
            onPayLoadRecieved: (endpointId, payload) {
              if (payload.bytes != null) {
                String message = String.fromCharCodes(payload.bytes!);
                print("Received: $message");
              }
            },
          );
        },
        onConnectionResult: (id, status) {
          print("Connection Result: $status");
        },
        onDisconnected: (id) {
          print("Disconnected: $id");
        },
      );

      print("Advertising Started");
    } catch (e) {
      print("Advertising Error: $e");
    }
  }

  /// Discover nearby devices
  Future<List<String>> discoverDevices() async {
    List<String> devices = [];

    try {
      await Nearby().startDiscovery(
        userName,
        strategy,
        onEndpointFound: (id, name, serviceId) {
          print("Found Device: $name");

          if (!devices.contains(name)) {
            devices.add(name);
          }

          Nearby().requestConnection(
            userName,
            id,
            onConnectionInitiated: (id, info) {
              print("Connecting to $name");

              Nearby().acceptConnection(
                id,
                onPayLoadRecieved: (endpointId, payload) {
                  if (payload.bytes != null) {
                    String message = String.fromCharCodes(payload.bytes!);
                    print("Received: $message");
                  }
                },
              );
            },
            onConnectionResult: (id, status) {
              print("Connection Status: $status");
            },
            onDisconnected: (id) {
              print("Disconnected: $id");
            },
          );
        },
        onEndpointLost: (id) {
          print("Device Lost: $id");
        },
      );

      print("Discovery Started");
    } catch (e) {
      print("Discovery Error: $e");
    }

    return devices;
  }

  /// Send message
  Future<void> sendMessage(String endpointId, String message) async {
    try {
      await Nearby().sendBytesPayload(
        endpointId,
        Uint8List.fromList(message.codeUnits),
      );

      print("Message Sent");
    } catch (e) {
      print("Send Error: $e");
    }
  }

  /// Stop all connections
  Future<void> stopAll() async {
    await Nearby().stopAllEndpoints();
    print("Stopped All Connections");
  }
}