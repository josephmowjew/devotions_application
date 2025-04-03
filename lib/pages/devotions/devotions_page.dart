import 'package:devotions_app/pages/devotions/blocs/devotions_bloc.dart';
import 'package:devotions_app/pages/devotions/views/devotions_list_view.dart';
import 'package:devotions_app/shared/repositories/devotions_repository.dart';
import 'package:devotions_app/shared/blocs/token_bloc/token_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The main page for viewing and managing devotions.
class DevotionsPage extends StatelessWidget {
  /// Creates a devotions page.
  const DevotionsPage({Key? key}) : super(key: key);

  /// Route name for navigation.
  static const String routeName = '/devotions';

  @override
  Widget build(BuildContext context) {
    print('📱 DEBUG - Building DevotionsPage');

    // Get token state for auth data
    final tokenState = context.watch<TokenCubit>().state;
    print('📱 DEBUG - TokenState: ${tokenState.toString()}');

    // Safely convert orgId to string if it exists
    final orgId = tokenState.orgId != null ? tokenState.orgId.toString() : '';
    final branchId = tokenState.branch ?? '';

    print(
      '📱 DEBUG - Using orgId=$orgId, branchId=$branchId for DevotionsBloc',
    );

    return BlocProvider(
      create: (context) {
        print('📱 DEBUG - Creating DevotionsBloc');
        // Create a new instance of DevotionsBloc with the repository
        final bloc = DevotionsBloc(
          devotionsRepository: context.read<DevotionsRepository>(),
        );

        // Directly load data using custom method
        WidgetsBinding.instance.addPostFrameCallback((_) {
          print(
            '📱 DEBUG - Initial fetch triggered with orgId=$orgId, branchId=$branchId',
          );

          bloc.fetchDevotions(
            page: 1,
            filters: {'organisationId': orgId, 'branchId': branchId},
          );
        });

        return bloc;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Devotions'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Implement search functionality
              },
            ),
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                // Implement filter functionality
              },
            ),
            // Debug refresh button
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                print('📱 DEBUG - Manual refresh triggered');
                final bloc = context.read<DevotionsBloc>();
                bloc.fetchDevotions(
                  page: 1,
                  filters: {'organisationId': orgId, 'branchId': branchId},
                );
              },
            ),
          ],
        ),
        body: const DevotionsListView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigate to create devotion page
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
