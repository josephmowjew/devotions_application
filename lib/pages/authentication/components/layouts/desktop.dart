import 'package:flutter/material.dart';

Widget buildDesktopLayout() {
  return Scaffold(
    body: Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Login Desktop Layout',
            // style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Add your action here
            },
            child: const Text('Click Me'),
          ),
        ],
      ),
    ),
  );
}
