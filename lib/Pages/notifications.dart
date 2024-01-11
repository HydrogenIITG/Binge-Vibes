import 'package:bingevibes/Pages/homepage.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});
  read() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      body: const SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Notifications',
              style: TextStyle(
                fontFamily: 'Solitreo',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'No notifications to show',
              style: TextStyle(
                fontFamily: 'Solitreo',
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: const ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.red)),
        onPressed: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const MyHome(),
            ),
            (route) => false),
        child: const Text('Back'),
      ),
    );
  }
}
