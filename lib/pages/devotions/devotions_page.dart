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
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          title: Text(
            'Devotions',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.indigo.shade900,
              letterSpacing: 0.5,
            ),
          ),
          centerTitle: false,
          elevation: 0.5,
          backgroundColor: Colors.white,
          foregroundColor: Colors.indigo.shade900,
          actions: [
            IconButton(
              icon: Icon(Icons.search_rounded, color: Colors.indigo.shade800),
              onPressed: () {
                // Implement search functionality
              },
            ),
            IconButton(
              icon: Icon(
                Icons.filter_list_rounded,
                color: Colors.indigo.shade800,
              ),
              onPressed: () {
                // Implement filter functionality
              },
            ),
            IconButton(
              icon: Icon(Icons.refresh_rounded, color: Colors.indigo.shade800),
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
          backgroundColor: Colors.indigo.shade600,
          elevation: 2,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
