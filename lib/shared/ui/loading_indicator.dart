import 'package:flutter/material.dart';

/// A reusable loading indicator component.
class LoadingIndicator extends StatelessWidget {
  /// Creates a loading indicator.
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
