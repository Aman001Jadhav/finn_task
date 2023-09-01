import 'package:finn_task/screens/dogImageScreen.dart';
import 'package:finn_task/screens/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DogImageScreen()));
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 148, 114, 241)),
                  child: const Center(
                    child: Text(
                      "Random dog images Screen",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  BluetoothManager.enableBluetooth();
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 148, 114, 241)),
                  child: const Center(
                    child: Text(
                      "Enable Bluetooth",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserDetailsScreen()));
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 148, 114, 241)),
                  child: const Center(
                    child: Text(
                      "Profile Screen",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Bluetooth Manager
class BluetoothManager {
  static const MethodChannel _channel = MethodChannel('your.neww.name');

  static Future<bool> enableBluetooth() async {
    try {
      final bool success = await _channel.invokeMethod('enableBluetooth');
      if (success) {
        print("Bluetooth enabled successfully");
      } else {
        print("Bluetooth enabling canceled or failed");
      }
      return success;
    } on PlatformException catch (e) {
      print('Error: ${e.message}');
      print("Enable Failedd");

      return false;
    }
  }
}
