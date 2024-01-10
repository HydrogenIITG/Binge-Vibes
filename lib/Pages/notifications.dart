import 'package:bingevibes/Pages/homepage.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});
  read() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.notifications_sharp),
                const Text(
                  'Notifications',
                  style: TextStyle(
                    fontFamily: 'Solitreo',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: read(),
                  child: const Text('Mark all as read'),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'No notifications to show',
              style: TextStyle(
                fontFamily: 'Solitreo',
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: ElevatedButton.icon(
        style: const ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.red)),
        onPressed: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const MyHome(),
            ),
            (route) => false),
        icon: const Icon(Icons.door_back_door_sharp),
        label: const Text('Back'),
      ),
    );
  }
}
