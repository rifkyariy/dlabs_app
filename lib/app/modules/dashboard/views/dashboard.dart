import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
            top: 96.0, left: 24.0, right: 24.0, bottom: 24.0),
        child: Text('home'),
      ),
    );
  }
}
