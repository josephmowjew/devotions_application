import 'package:flutter/material.dart';
import 'package:flutter_ui_modules/modules/cards/reusable_card.dart';
import 'package:flutter_ui_modules/modules/cards/card_body.dart';
import 'models/activity.dart';
import 'components/activity_search.dart';
import 'components/activity_item.dart';
import 'components/add_note_section.dart';
import 'utils/theme_constants.dart';

class ActivityNotes extends StatelessWidget {
  final List<Activity> activities;
  final Function(String) onSearch;
  final VoidCallback onFilter;
  final Function(String)? onAddNote;
  final double? width;
  final double? height;
  final bool isLoading;
  final bool hasReachedMax;
  final int totalItems;
  final String? error;
  final ScrollController? scrollController;

  const ActivityNotes({
    Key? key,
    required this.activities,
    required this.onSearch,
    required this.onFilter,
    this.onAddNote,
    this.width,
    this.height,
    this.isLoading = false,
    this.hasReachedMax = false,
    this.totalItems = 0,
    this.error,
    this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ReusableCard(
          width: width,
          padding: const EdgeInsets.all(24),
          body: CardBody(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Activity Notes',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0B1F44),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit_rounded),
                      onPressed: () {
                        // TODO: Implement edit functionality
                      },
                      color: Theme.of(context).primaryColor,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ActivitySearch(
                  onSearch: onSearch,
                  onFilter: onFilter,
                ),
                const SizedBox(height: 24),
                if (error != null)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        error!,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  )
                else if (activities.isEmpty && !isLoading)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        'No activities found',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: activities.length + (isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == activities.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      final activity = activities[index];
                      final isLast = index == activities.length - 1;
                      return ActivityItem(
                        activity: activity,
                        isLast: isLast,
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
        if (onAddNote != null) ...[
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: AddNoteSection(
              onSubmit: onAddNote!,
              onClose: () {},
            ),
          ),
        ],
      ],
    ),
    );
  }
}