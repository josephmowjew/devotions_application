import 'package:devotions_app/modules/notes/activity_notes.dart';
import 'package:devotions_app/pages/activity_notes/blocs/activity_note_bloc.dart';
import 'package:devotions_app/shared/models/activity_note_read_dto.dart';
import 'package:devotions_app/shared/ui/empty_state_view.dart';
import 'package:devotions_app/shared/ui/error_view.dart';
import 'package:devotions_app/shared/ui/loading_indicator.dart';
import 'package:devotions_app/shared/blocs/token_bloc/token_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyvepulse_components/blocs/paginated_bloc/paginated_event.dart';

import 'package:lyvepulse_components/blocs/paginated_bloc/paginated_state.dart';
import 'package:devotions_app/modules/notes/models/activity.dart';


/// A view that displays a list of activity notes with pagination and actions.
class ActivityNotesListView extends StatefulWidget {
  const ActivityNotesListView({super.key});

  @override
  State<ActivityNotesListView> createState() => _ActivityNotesListViewState();
}

class _ActivityNotesListViewState extends State<ActivityNotesListView> {
  final ScrollController _scrollController = ScrollController();
  late Map<String, dynamic> _filters;

  @override
  void initState() {
    super.initState();
    _setupScrollController();
    _initializeFilters();
    _loadInitialData();
  }

  void _initializeFilters() {
    final tokenState = context.read<TokenCubit>().state;
    _filters = {
      'organizationId': tokenState.orgId ?? 0,
      'branchId': tokenState.branch ?? '',
    };
  }

  void _loadInitialData() {
    final bloc = context.read<ActivityNoteBloc>();
    bloc.add(ApplyFiltersAndSorting(filters: _filters));
  }

  void _setupScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8) {
        final bloc = context.read<ActivityNoteBloc>();
        if (bloc.state is! PaginatedLoading && !bloc.state.hasReachedMax) {
          bloc.add(ApplyFiltersAndSorting(filters: _filters));
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityNoteBloc, PaginatedState<ActivityNoteReadDto>>(
      builder: (context, state) {
        // Initial state - show loading
        if (state is PaginatedInitial<ActivityNoteReadDto>) {
          return const LoadingIndicator();
        }

        // Loading state with no existing items
        if (state is PaginatedLoading<ActivityNoteReadDto> && state.items.isEmpty) {
          return const LoadingIndicator();
        }

        // Error state
        if (state is PaginatedFailure<ActivityNoteReadDto>) {
          return ErrorView(
            message: 'Error: ${state.error}',
            onRetry: () {
              context.read<ActivityNoteBloc>().add(
                    ApplyFiltersAndSorting(filters: _filters),
                  );
            },
          );
        }

        // Empty state
        if (state.items.isEmpty) {
          return const EmptyStateView(
            message: "No activity notes available.",
            icon: Icons.note_alt_outlined,
          );
        }

        // Success or loading more state
        return ActivityNotes(
          activities: state.items.map((note) => Activity(
            id: note.id?.toString() ?? '',
            type: ActivityType.informationUpdate,
            title: note.noteType ?? 'Untitled Note',
            description: note.description?.text ?? '',
            timestamp: note.createdAt ?? DateTime.now(),
            user: note.creatorName ?? note.creatorEmail ?? 'Unknown',
            note: note.description?.text ?? '',
          )).toList(),
          isLoading: state is PaginatedLoading,
          hasReachedMax: state.hasReachedMax,
          totalItems: state.totalItems,
          error: state is PaginatedFailure ? (state as PaginatedFailure).error : null,
          onSearch: (query) {
            context.read<ActivityNoteBloc>().add(
                  ApplyFiltersAndSorting(
                    filters: _filters,
                    searchQuery: query,
                  ),
                );
          },
          onFilter: () {
            // Placeholder for filter action
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Filter functionality not yet implemented')),
            );
          },
          onAddNote: (note) {
            // Placeholder for add note action
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Add note: $note')),
            );
          },
          scrollController: _scrollController,
        );
      },
    );
  }
}
