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
import 'package:lyvepulse_components/blocs/paginated_bloc/paginated_state.dart';
import 'package:lyvepulse_components/blocs/paginated_bloc/paginated_event.dart';

/// A view that displays a list of devotions using ReusableCard component.
class DevotionsListView extends StatelessWidget {
  const DevotionsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DevotionsBloc, PaginatedState<Devotion>>(
      builder: (context, state) {
        // Initial state - show loading
        if (state is PaginatedInitial<Devotion>) {
          return const LoadingIndicator();
        }

        // Loading state
        if (state is PaginatedLoading<Devotion>) {
          return const LoadingIndicator();
        }

        // Error state
        if (state is PaginatedFailure<Devotion>) {
          final errorMessage = 'Error: ${state.error}';

          return ErrorView(
            message: errorMessage,
            onRetry: () {
              final bloc = context.read<DevotionsBloc>();
              final tokenState = context.read<TokenCubit>().state;
              final orgId =
                  tokenState.orgId != null ? tokenState.orgId.toString() : '';
              final branchId = tokenState.branch ?? '';

              // Refresh with current filters
              bloc.add(ApplyFiltersAndSorting(
                filters: {'organisationId': orgId, 'branchId': branchId},
              ));
            },
          );
        }

        // Success state with data
        if (state is PaginatedSuccess<Devotion>) {

          // Check if items are empty
          if (state.items.isEmpty) {
          
            return const EmptyStateView(
              message: "No devotions available.",
              icon: Icons.book_outlined,
            );
          }


          try {
            // Create a beautiful UI with modern styling
            return Container(
              color: Colors.grey.shade50,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Page header with title and actions
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Devotions",
                            style: Theme.of(
                              context,
                            ).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo.shade900,
                              letterSpacing: 0.5,
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: () {
                              // Handle show all
                            },
                            icon: const Icon(Icons.view_list_outlined),
                            label: const Text("Show All"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.indigo,
                              side: BorderSide(color: Colors.indigo.shade300),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // List of devotion cards
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.items.length,
                        itemBuilder: (context, index) {
                          final devotion = state.items[index];
                          return _buildDevotionCard(context, devotion);
                        },
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } catch (e) {
            return ErrorView(
              message: 'Error displaying devotions: $e',
              onRetry: () {
                final bloc = context.read<DevotionsBloc>();
                final tokenState = context.read<TokenCubit>().state;
                final orgId =
                    tokenState.orgId != null ? tokenState.orgId.toString() : '';
                final branchId = tokenState.branch ?? '';

                bloc.add(ApplyFiltersAndSorting(
                  filters: {'organisationId': orgId, 'branchId': branchId},
                ));
              },
            );
          }
        }

      
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

                  // Force refresh with current filters
                  bloc.add(ApplyFiltersAndSorting(
                    filters: {'organisationId': orgId, 'branchId': branchId},
                  ));
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
      titleColor: Colors.indigo.shade900,
      titleFontWeight: FontWeight.w600,
      titleFontSize: 22,
      showBottomBorder: false,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, size: 20),
          onPressed: () {
            // Show options menu
          },
        ),
      ],
    );

    // Format the date for better display
    String formattedDate = '';
    if (devotion.createdAt != null) {
      try {
        final date = DateTime.parse(devotion.createdAt!);
        formattedDate =
            "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
      } catch (e) {
        formattedDate = '';
      }
    }

    // Create the body with devotion content
    final body = CardBody(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author attribution if available
            if (devotion.createdBy != null) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  "By: Author ${devotion.createdBy}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],

            // Scripture Reading Section with improved styling
            if (devotion.scriptureReading != null) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  "Scripture:",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  devotion.scriptureReading!,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade900),
                ),
              ),
            ],

            // Scripture Text Section with beautiful styling
            if (devotion.scriptureText != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                ),
                child: Text(
                  '"${devotion.scriptureText!}"',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade800,
                    height: 1.5,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],

            // Devotion Text Section with better typography
            if (devotion.devotion != null) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  "Devotion:",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  devotion.devotion!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade800,
                    height: 1.6,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],

            // Prayer Section with updated design
            if (devotion.prayer != null) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  "Prayer:",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  devotion.prayer!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade800,
                    fontStyle: FontStyle.italic,
                    height: 1.6,
                  ),
                ),
              ),
            ],

            // Date display with subtle styling
            if (formattedDate.isNotEmpty)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, right: 4),
                  child: Text(
                    formattedDate,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
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
          icon: const Icon(Icons.visibility_outlined, size: 18),
          label: const Text("View"),
          style: TextButton.styleFrom(foregroundColor: Colors.indigo),
        ),
        TextButton.icon(
          onPressed: () {
            // Share devotion
          },
          icon: const Icon(Icons.share_outlined, size: 18),
          label: const Text("Share"),
          style: TextButton.styleFrom(foregroundColor: Colors.indigo),
        ),
      ],
      showTopBorder: true,
      alignment: MainAxisAlignment.end,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );

    // Return the complete ReusableCard with enhanced styling
    return ReusableCard(
      header: header,
      body: body,
      footer: footer,
      isClickable: true,
      onTap: () {
        // Navigate to devotion details
      },
      elevation: 1.0,
      borderRadius: 16.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      backgroundColor: Colors.white,
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
