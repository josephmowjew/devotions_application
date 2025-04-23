import 'package:devotions_app/shared/models/activity_note_read_dto.dart';
import 'package:devotions_app/shared/repositories/activity_note_repository.dart';
import 'package:devotions_app/shared/blocs/token_bloc/token_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyvepulse_components/blocs/paginated_bloc/paginated_bloc.dart';
import 'package:lyvepulse_components/blocs/paginated_bloc/paginated_state.dart';
import 'package:lyvepulse_components/utils/pair.dart';

/// BLoC responsible for managing paginated [ActivityNoteReadDto] data.
class ActivityNoteBloc extends PaginatedBloc<ActivityNoteReadDto> {
  final ActivityNoteRepository repository;
  static const int pageSize = 10;

  ActivityNoteBloc({required this.repository}) : super();

  @override
  Future<void> loadPage({
    required int page,
    required Map<String, dynamic> filters,
    String? searchQuery,
    String? sortField,
    bool ascending = true,
    required Emitter<PaginatedState<ActivityNoteReadDto>> emit,
  }) async {
    try {
      // 1. Emit Loading State
      if (state is! PaginatedLoading) {
        emit(PaginatedLoading<ActivityNoteReadDto>(
          items: state.items,
          hasReachedMax: state.hasReachedMax,
          totalItems: state.totalItems,
          filters: filters,
          searchQuery: searchQuery,
          sortField: sortField,
          ascending: ascending,
          loadMore: page > 0,
        ));
      }

      // 2. Fetch Data
      final result = await fetchPage(
        page: page,
        filters: filters,
        searchQuery: searchQuery,
        sortField: sortField,
        ascending: ascending,
      );

      // 3. Process Results
      final totalItems = result.first;
      final newItems = result.second;
      final hasReachedMax = (page + 1) * pageSize >= totalItems;

      // 4. Update Items List
      final updatedItems = page == 0 ? newItems : [...state.items, ...newItems];

      // 5. Emit Success State
      emit(PaginatedSuccess<ActivityNoteReadDto>(
        items: updatedItems,
        hasReachedMax: hasReachedMax,
        totalItems: totalItems,
        filters: filters,
        searchQuery: searchQuery,
        sortField: sortField,
        ascending: ascending,
        loadMore: false,
      ));
    } catch (e) {
      // 6. Handle Errors
      final errorMessage = (e is ServerException) ? e.message : e.toString();
      emit(PaginatedFailure<ActivityNoteReadDto>(
        items: state.items,
        error: errorMessage,
        totalItems: state.totalItems,
        filters: filters,
        searchQuery: searchQuery,
        sortField: sortField,
        ascending: ascending,
      ));
    }
  }

  @override
  Future<Pair<int, List<ActivityNoteReadDto>>> fetchPage({
    required int page,
    required Map<String, dynamic> filters,
    String? searchQuery,
    String? sortField,
    bool ascending = true,
  }) async {
    try {
      // 1. Extract Required Filters
      final organizationId = filters['organizationId'] as int? ?? 0;
      final branchId = filters['branchId'] as String? ?? '';

      // Ensure we have valid values
      if (organizationId == 0 || branchId.isEmpty) {
        // Try to get values from TokenCubit
        final tokenCubit = TokenCubit();
        await tokenCubit.loadTokenAndBranch();
        final orgId = tokenCubit.state.orgId;
        final branch = tokenCubit.state.branch;

        if (orgId != null && orgId != 0) {
          filters['organizationId'] = orgId;
        }

        if (branch != null && branch.isNotEmpty) {
          filters['branchId'] = branch;
        }
      }

      // 2. Call Repository
      final response = await repository.getAllActivityNotes(
        organizationId: filters['organizationId'] as int? ?? 0,
        branchId: filters['branchId'] as String? ?? '',
        page: page,
        pageSize: pageSize,
        creatorEmail: filters['creatorEmail'] as String?,
        entityType: filters['entityType'] as List<String>?,
        entityId: filters['entityId'] as List<String>?,
        noteType: filters['noteType'] as List<String>?,
        creatorType: filters['creatorType'] as List<String>?,
        startDate: filters['startDate'] as String?,
        endDate: filters['endDate'] as String?,
        searchKeyword: searchQuery,
      );

      // 3. Process Response
      final items = response.content ?? [];
      final totalElements = response.totalElements ?? items.length;

      // 4. Return Total Count and Items
      return Pair(totalElements, items);
    } catch (e) {
      final errorMessage = (e is ServerException) ? e.message : e.toString();
      throw ServerException(errorMessage);
    }
  }
}

// Reusing ServerException from the data source layer
class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}