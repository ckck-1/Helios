import 'package:flutter/material.dart';

class BluetoothOverlay extends StatefulWidget {
  const BluetoothOverlay({super.key});

  @override
  State<BluetoothOverlay> createState() => _BluetoothOverlayState();
}

class _BluetoothOverlayState extends State<BluetoothOverlay> {
  bool showDevices = false;

  // Example devices
  final List<Map<String, dynamic>> devices = [
    {'name': 'Apple Watch', 'connected': false},
    {'name': 'Galaxy Watch', 'connected': true},
    {'name': 'Fitbit', 'connected': false},
    {'name': 'Mi Band', 'connected': false},
  ];

  void toggleConnection(int index) {
    setState(() {
      devices[index]['connected'] = !devices[index]['connected'];
    });
  }

  void addDevice() {
    setState(() {
      devices.add({'name': 'New Device', 'connected': false});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Your main page content goes here
        Positioned(
          top: 20,
          right: 20,
          child: IconButton(
            icon: const Icon(Icons.bluetooth, color: Colors.white, size: 32),
            onPressed: () {
              setState(() {
                showDevices = !showDevices;
              });
            },
          ),
        ),

        // Bluetooth device card overlay
        if (showDevices)
          Positioned(
            top: 70,
            right: 20,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 220,
              height: 80.0 + devices.length * 60, // expands with devices
              decoration: BoxDecoration(
                color: Colors.grey[900]!.withOpacity(0.95),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Bluetooth Devices',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: devices.length,
                      itemBuilder: (context, index) {
                        final device = devices[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                device['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => toggleConnection(index),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: device['connected']
                                        ? Colors.green
                                        : Colors.orange,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    device['connected']
                                        ? 'Connected'
                                        : 'Connect',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: addDevice,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFA05C), Color(0xFFF06500)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        '+ Add Device',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
