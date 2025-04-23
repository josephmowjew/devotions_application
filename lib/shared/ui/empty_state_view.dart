import 'package:flutter/material.dart';

/// A reusable empty state view component.
class EmptyStateView extends StatelessWidget {
  /// The message to display.
  final String message;

  /// Optional icon to display above the message.
  final IconData? icon;

  /// Optional action button.
  final Widget? action;

  /// Creates an empty state view.
  const EmptyStateView({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(icon, size: 64, color: Theme.of(context).disabledColor),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          if (action != null)
            Padding(padding: const EdgeInsets.only(top: 24), child: action),
        ],
      ),
    );
  }
}
