import 'package:devotions_app/pages/devotions/blocs/devotions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:devotions_app/shared/models/devotion.dart';
import 'package:devotions_app/shared/ui/loading_indicator.dart';
import 'package:devotions_app/shared/ui/empty_state_view.dart';
import 'package:devotions_app/shared/ui/error_view.dart';
import 'package:devotions_app/shared/blocs/token_bloc/token_bloc.dart';
import 'package:flutter_ui_modules/modules/cards/reusable_card.dart';
import 'package:flutter_ui_modules/modules/cards/card_header.dart';
import 'package:flutter_ui_modules/modules/cards/card_body.dart';
import 'package:flutter_ui_modules/modules/cards/card_footer.dart';

/// A view that displays a list of devotions using ReusableCard component.
class DevotionsListView extends StatelessWidget {
  const DevotionsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DevotionsBloc, DevotionsState>(
      builder: (context, state) {
        // Debug logging to understand what state we're getting
        print('📱 DEBUG - DevotionsListView state: ${state.runtimeType}');

        // Initial state - show loading
        if (state is DevotionsInitial) {
          print('📱 DEBUG - DevotionsListView rendering Initial state');
          return const LoadingIndicator();
        }

        // Loading state
        if (state is DevotionsLoading) {
          print('📱 DEBUG - DevotionsListView rendering Loading state');
          return const LoadingIndicator();
        }

        // Error state
        if (state is DevotionsError) {
          print('📱 DEBUG - DevotionsListView rendering Error state');
          final errorMessage = 'Error: ${state.message}';

          return ErrorView(
            message: errorMessage,
            onRetry: () {
              final bloc = context.read<DevotionsBloc>();
              final tokenState = context.read<TokenCubit>().state;
              final orgId =
                  tokenState.orgId != null ? tokenState.orgId.toString() : '';
              final branchId = tokenState.branch ?? '';

              // Call appropriate method to refresh with actual org/branch values
              bloc.fetchDevotions(
                page: 1,
                filters: {'organisationId': orgId, 'branchId': branchId},
              );
            },
          );
        }

        // Loaded state with data
        if (state is DevotionsLoaded) {
          print('📱 DEBUG - DevotionsListView rendering Loaded state');

          // Check if items are empty
          if (state.items.isEmpty) {
            print(
              '📱 DEBUG - DevotionsListView rendering Empty state (items empty)',
            );
            return const EmptyStateView(
              message: "No devotions available.",
              icon: Icons.book_outlined,
            );
          }

          print('📱 DEBUG - Devotions loaded: ${state.items.length}');

          // Debug log to inspect devotion data
          state.items.forEach((devotion) {
            print('📱 DEBUG - Devotion: ${devotion.toJson()}');
            print('📱 DEBUG - title: ${devotion.title}');
            print('📱 DEBUG - devotion text: ${devotion.devotion}');
            print('📱 DEBUG - scriptureReading: ${devotion.scriptureReading}');
            print('📱 DEBUG - scriptureText: ${devotion.scriptureText}');
            print('📱 DEBUG - prayer: ${devotion.prayer}');
            print('📱 DEBUG - createdAt: ${devotion.createdAt}');
            print('📱 DEBUG - createdBy: ${devotion.createdBy}');
          });

          try {
            // Create a beautiful UI with ReusableCard
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Page header with actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Devotions",
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {
                              // Handle show all
                            },
                            icon: const Icon(Icons.view_list),
                            label: const Text("Show All"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: 8),
                          FloatingActionButton(
                            onPressed: () {
                              // Handle add new
                            },
                            mini: true,
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // List of devotion cards
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final devotion = state.items[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: _buildDevotionCard(context, devotion),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } catch (e) {
            print('📱 DEBUG - Error rendering loaded state: $e');
            return ErrorView(
              message: 'Error displaying devotions: $e',
              onRetry: () {
                final bloc = context.read<DevotionsBloc>();
                final tokenState = context.read<TokenCubit>().state;
                final orgId =
                    tokenState.orgId != null ? tokenState.orgId.toString() : '';
                final branchId = tokenState.branch ?? '';

                bloc.fetchDevotions(
                  page: 1,
                  filters: {'organisationId': orgId, 'branchId': branchId},
                );
              },
            );
          }
        }

        // If we reach here, render fallback placeholder and debug
        print(
          '📱 DEBUG - No matching state found, showing placeholder with manual refresh button',
        );
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Waiting for data...'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final bloc = context.read<DevotionsBloc>();
                  final tokenState = context.read<TokenCubit>().state;
                  final orgId =
                      tokenState.orgId != null
                          ? tokenState.orgId.toString()
                          : '';
                  final branchId = tokenState.branch ?? '';

                  // Force refresh
                  bloc.fetchDevotions(
                    page: 1,
                    filters: {'organisationId': orgId, 'branchId': branchId},
                  );
                },
                child: const Text('Refresh'),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Build a beautiful card for a devotion using ReusableCard
  Widget _buildDevotionCard(BuildContext context, Devotion devotion) {
    // Create a header with the devotion title
    final header = CardHeader(
      title: devotion.title ?? 'Untitled Devotion',
      titleColor: Theme.of(context).primaryColor,
      titleFontWeight: FontWeight.bold,
      showBottomBorder: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, size: 20),
          onPressed: () {
            // Show options menu
          },
        ),
      ],
    );

    // Create the body with devotion content
    final body = CardBody(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Scripture Reading Section
            if (devotion.scriptureReading != null) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.menu_book, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Scripture: ${devotion.scriptureReading}",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],

            // Scripture Text Section
            if (devotion.scriptureText != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  '"${devotion.scriptureText!}"',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Devotion Text Section
            if (devotion.devotion != null) ...[
              Text(
                devotion.devotion!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
            ],

            // Prayer Section
            if (devotion.prayer != null) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.volunteer_activism,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Prayer:",
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          devotion.prayer!,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],

            // Metadata Section
            if (devotion.createdAt != null || devotion.createdBy != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (devotion.createdBy != null)
                    Text(
                      "By: ${devotion.createdBy}",
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                  if (devotion.createdAt != null)
                    Text(
                      "Created: ${_formatDate(devotion.createdAt!)}",
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                ],
              ),
          ],
        ),
      ),
    );

    // Create footer with actions
    final footer = CardFooter(
      actions: [
        TextButton.icon(
          onPressed: () {
            // View full devotion
          },
          icon: const Icon(Icons.visibility, size: 16),
          label: const Text("View"),
        ),
        TextButton.icon(
          onPressed: () {
            // Share devotion
          },
          icon: const Icon(Icons.share, size: 16),
          label: const Text("Share"),
        ),
      ],
      showTopBorder: true,
      alignment: MainAxisAlignment.end,
    );

    // Return the complete ReusableCard
    return ReusableCard(
      header: header,
      body: body,
      footer: footer,
      isClickable: true,
      onTap: () {
        // Navigate to devotion details
      },
      elevation: 2.0,
      borderRadius: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
    );
  }

  /// Format date string to a more readable format
  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    } catch (e) {
      return dateString;
    }
  }
}
