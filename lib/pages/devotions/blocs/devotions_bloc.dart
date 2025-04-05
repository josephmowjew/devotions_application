import 'package:devotions_app/core/errors/errors_exports.dart';
import 'package:devotions_app/shared/repositories/devotions_repository.dart';
import 'package:devotions_app/shared/models/devotion.dart';
import 'package:lyvepulse_components/blocs/paginated_bloc/paginated_bloc.dart';
import 'package:lyvepulse_components/blocs/paginated_bloc/paginated_state.dart';
import 'package:lyvepulse_components/utils/pair.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// BLoC responsible for managing paginated Devotions data.
class DevotionsBloc extends PaginatedBloc<Devotion> {
  final DevotionsRepository devotionsRepository;
  static const int pageSize = 10;

  /// Constructs the DevotionsBloc with a required repository.
  DevotionsBloc({required this.devotionsRepository}) : super();


  Future<void> loadPage({
    required int page,
    required Map<String, dynamic> filters,
    String? searchQuery,
    String? sortField,
    bool ascending = true,
    required Emitter<PaginatedState<Devotion>> emit,
  }) async {
    try {
      // Emit loading state while preserving current items
      if (state is! PaginatedLoading) {
        emit(PaginatedLoading<Devotion>(
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

      final result = await fetchPage(
        page: page,
        filters: filters,
        searchQuery: searchQuery,
        sortField: sortField,
        ascending: ascending,
      );

      final totalItems = result.first;
      final newItems = result.second;
      
      // Calculate if we've reached the maximum items
      final hasReachedMax = (page + 1) * pageSize >= totalItems;

      // For page 0, replace items. For other pages, append items
      final updatedItems = page == 0 
          ? newItems 
          : [...state.items, ...newItems];

      emit(PaginatedSuccess<Devotion>(
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
      final errorMessage = (e is ServerException) ? e.message : e.toString();
      
      emit(PaginatedFailure<Devotion>(
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
  Future<Pair<int, List<Devotion>>> fetchPage({
    required int page,
    required Map<String, dynamic> filters,
    String? searchQuery,
    String? sortField,
    bool ascending = true,
  }) async {
   
    try {
      // Extract required filters (assuming organisationId and branchId are mandatory)
      final organisationId = filters['organisationId'] as String? ?? '';
      final branchId = filters['branchId'] as String? ?? '';

     

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

      if (responseList.isEmpty) {
        return Pair(0, []);
      }

      // Get the first response object, which contains our data
      final responseObj = responseList.first;

      // Extract devotions from the content
      List<Devotion> devotions = [];

      if (responseObj.content is List) {
        devotions = (responseObj.content as List)
            .map(
              (item) => item is Devotion
                  ? item
                  : Devotion.fromJson(item as Map<String, dynamic>),
            )
            .toList();
      } else if (responseObj.content is Map<String, dynamic>) {
        devotions = [
          Devotion.fromJson(responseObj.content as Map<String, dynamic>),
        ];
      } else if (responseObj.content is Devotion) {
        devotions = [responseObj.content as Devotion];
      }

      // Get total count for pagination
      final totalElements = responseObj.totalElements ?? devotions.length;
      return Pair(totalElements, devotions);
    } catch (e) {
      final errorMessage = (e is ServerException) ? e.message : e.toString();
      throw ServerException(errorMessage);
    }
  }
}
