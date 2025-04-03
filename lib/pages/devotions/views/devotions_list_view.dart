import 'package:devotions_app/pages/devotions/blocs/devotions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:devotions_app/shared/models/devotion.dart';
import 'package:devotions_app/shared/ui/loading_indicator.dart';
import 'package:devotions_app/shared/ui/empty_state_view.dart';
import 'package:devotions_app/shared/ui/error_view.dart';
import 'package:devotions_app/shared/blocs/token_bloc/token_bloc.dart';

/// A view that displays a list of devotions using MainCard component.
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

          try {
            // Create a simple list view instead of using MainCard which has compatibility issues
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Devotions",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              // Handle show all
                            },
                            child: const Text("Show All"),
                          ),
                          IconButton(
                            onPressed: () {
                              // Handle add new
                            },
                            icon: const Icon(
                              Icons.add_circle,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final devotion = state.items[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  devotion.title ?? "No Title",
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                if (devotion.createdAt != null)
                                  Text("Created: ${devotion.createdAt}"),
                                if (devotion.createdBy != null)
                                  Text("By: ${devotion.createdBy}"),
                                if (devotion.devotion != null)
                                  Text("Devotion: ${devotion.devotion}"),
                                if (devotion.scriptureReading != null)
                                  Text(
                                    "Scripture: ${devotion.scriptureReading}",
                                  ),
                              ],
                            ),
                          ),
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
}
