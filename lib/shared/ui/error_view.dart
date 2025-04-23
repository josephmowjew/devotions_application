import 'package:flutter/material.dart';

/// A reusable error view component.
class ErrorView extends StatelessWidget {
  /// The error message to display.
  final String message;

  /// Optional callback when retry is pressed.
  final VoidCallback? onRetry;

  /// Optional icon to display above the error message.
  final IconData icon;

  /// Creates an error view.
  const ErrorView({
    super.key,
    required this.message,
    this.onRetry,
    this.icon = Icons.error_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Theme.of(context).colorScheme.error),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          if (onRetry != null)
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: ElevatedButton(
                onPressed: onRetry,
                child: const Text('Retry'),
              ),
            ),
        ],
      ),
    );
  }
}
