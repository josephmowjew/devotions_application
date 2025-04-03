import 'dart:developer';
import 'package:devotions_app/core/errors/errors_exports.dart';
import 'package:devotions_app/shared/repositories/devotions_repository.dart';
import 'package:devotions_app/shared/models/devotion.dart';
import 'package:lyvepulse_components/blocs/paginated_bloc/paginated_bloc.dart'; // Assumed base package
import 'package:lyvepulse_components/blocs/paginated_bloc/paginated_state.dart'; // Import state class
import 'package:lyvepulse_components/utils/pair.dart'; // Assumed utility for Pair
import 'package:flutter_bloc/flutter_bloc.dart';

// Define the base state class
abstract class DevotionsState {}

// Initial state
class DevotionsInitial extends DevotionsState {}

// Loading state
class DevotionsLoading extends DevotionsState {}

// Success state with data
class DevotionsLoaded extends DevotionsState {
  final List<Devotion> items;
  final int totalItems;
  final int page;
  final bool hasReachedMax;

  DevotionsLoaded({
    required this.items,
    required this.totalItems,
    required this.page,
    this.hasReachedMax = false,
  });
}

// Error state
class DevotionsError extends DevotionsState {
  final String message;

  DevotionsError({required this.message});
}

/// BLoC responsible for managing paginated Devotions data.
class DevotionsBloc extends Cubit<DevotionsState> {
  final DevotionsRepository devotionsRepository;

  /// Constructs the DevotionsBloc with a required repository.
  DevotionsBloc({required this.devotionsRepository})
    : super(DevotionsInitial()) {
    print('📱 DEBUG - DevotionsBloc initialized');
  }

  /// Fetch devotions with the given parameters
  Future<void> fetchDevotions({
    required int page,
    required Map<String, dynamic> filters,
    String? searchQuery,
    String? sortField,
    bool ascending = true,
  }) async {
    print('📱 DEBUG - Fetching devotions for page $page');

    // Emit loading state
    emit(DevotionsLoading());

    try {
      const int pageSize = 10; // Default page size
      log("Fetching Devotions page $page with pageSize $pageSize...");

      // Extract required filters (assuming organisationId and branchId are mandatory)
      final organisationId = filters['organisationId'] as String? ?? '';
      final branchId = filters['branchId'] as String? ?? '';

      print(
        '📱 DEBUG - Fetching with orgId=$organisationId, branchId=$branchId',
      );

      // Call the repository's paginated method
      final responseList = await devotionsRepository.getAllDevotions(
        date: filters['date'] as String?,
        search: searchQuery,
        page: page,
        pageSize: pageSize,
        createdBy: filters['createdBy'] as String?,
        organisationId: organisationId,
        branchId: branchId,
      );

      print(
        '📱 DEBUG - Repository returned ${responseList.length} response items',
      );

      if (responseList.isEmpty) {
        print('📱 DEBUG - Empty response list, emitting empty loaded state');
        emit(
          DevotionsLoaded(
            items: [],
            totalItems: 0,
            page: page,
            hasReachedMax: true,
          ),
        );
        return;
      }

      // Get the first response object, which contains our data
      final responseObj = responseList.first;
      print('📱 DEBUG - First response type: ${responseObj.runtimeType}');

      // Extract devotions from the content
      List<Devotion> devotions = [];

      if (responseObj.content is List) {
        print('📱 DEBUG - Content is List type');
        // Handle list of devotions in content
        devotions =
            (responseObj.content as List)
                .map(
                  (item) =>
                      item is Devotion
                          ? item
                          : Devotion.fromJson(item as Map<String, dynamic>),
                )
                .toList();
      } else if (responseObj.content is Map<String, dynamic>) {
        print('📱 DEBUG - Content is Map type');
        // Handle single devotion in content
        devotions = [
          Devotion.fromJson(responseObj.content as Map<String, dynamic>),
        ];
      } else if (responseObj.content is Devotion) {
        print('📱 DEBUG - Content is Devotion type');
        // Handle case where content is already a Devotion object
        devotions = [responseObj.content as Devotion];
      } else {
        print(
          '📱 DEBUG - Content is unknown type: ${responseObj.content.runtimeType}',
        );
      }

      // Get total count for pagination
      final totalElements = responseObj.totalElements ?? devotions.length;

      log("Successfully fetched ${devotions.length} devotions for page $page.");
      print(
        '📱 DEBUG - Emitting loaded state with ${devotions.length} devotions',
      );

      // Emit the loaded state with the data
      emit(
        DevotionsLoaded(
          items: devotions,
          totalItems: totalElements,
          page: page,
          hasReachedMax: devotions.length < pageSize,
        ),
      );
    } catch (e) {
      log("Error fetching Devotions page: $e");
      print('📱 DEBUG - Error in fetchDevotions: $e');
      final errorMessage = (e is ServerException) ? e.message : e.toString();
      emit(DevotionsError(message: errorMessage));
    }
  }
}
