import 'package:flutter/material.dart';

/// A reusable loading indicator component.
class LoadingIndicator extends StatelessWidget {
  /// Creates a loading indicator.
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
