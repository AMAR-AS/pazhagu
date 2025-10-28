
import 'package:flutter/material.dart';
import 'package:pazhagu/screens/qr_scanner_screen.dart';

class LinkDeviceScreen extends StatefulWidget {
  const LinkDeviceScreen({Key? key}) : super(key: key);

  @override
  State<LinkDeviceScreen> createState() => _LinkDeviceScreenState();
}

class _LinkDeviceScreenState extends State<LinkDeviceScreen> {
  // Dummy data for active devices
  final List<Map<String, dynamic>> _activeDevices = [
    {'name': 'Desktop - Windows', 'isLocked': false},
    {'name': 'Chrome (Web)', 'isLocked': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Linked Devices'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QRScannerScreen(),
                  ),
                );

                if (result != null) {
                  // For now, just print the result to the console
                  debugPrint('Scanned QR code: $result');
                }
              },
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Link a New Device'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Active Devices',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _activeDevices.length,
                itemBuilder: (context, index) {
                  final device = _activeDevices[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.devices),
                      title: Text(device['name']),
                      trailing: IconButton(
                        icon: Icon(
                          device['isLocked'] ? Icons.lock : Icons.lock_open,
                        ),
                        onPressed: () {
                          setState(() {
                            device['isLocked'] = !device['isLocked'];
                          });
                        },
                      ),
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
