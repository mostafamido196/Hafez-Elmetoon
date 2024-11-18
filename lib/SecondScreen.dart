import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final String title;
  const SecondScreen({required String this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
          child: Text('Back to Home Screen'),
        ),
      ),
    );
  }
}
