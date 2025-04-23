import 'package:flutter/material.dart';
import '../utils/theme_constants.dart';

class ActivitySearch extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String) onSearch;
  final VoidCallback onFilter;

  const ActivitySearch({
    Key? key,
    this.controller,
    required this.onSearch,
    required this.onFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: ActivityNotesTheme.searchBackground,
        borderRadius: BorderRadius.circular(ActivityNotesTheme.searchBorderRadius),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Icon(
            Icons.search,
            size: 20,
            color: ActivityNotesTheme.searchIconColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onSearch,
              decoration: const InputDecoration(
                hintText: 'Search activities',
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: ActivityNotesTheme.timestampStyle.copyWith(
                color: ActivityNotesTheme.titleText,
              ),
            ),
          ),
          Container(
            width: 1,
            height: 24,
            color: ActivityNotesTheme.dividerColor,
          ),
          IconButton(
            onPressed: onFilter,
            icon: Icon(
              Icons.tune,
              size: 20,
              color: ActivityNotesTheme.searchIconColor,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            constraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 40,
            ),
          ),
        ],
      ),
    );
  }
} 