import 'package:devotions_app/pages/activity_notes/blocs/activity_note_bloc.dart';
import 'package:devotions_app/pages/activity_notes/views/activity_notes_list_view.dart';
import 'package:devotions_app/shared/repositories/activity_note_repository.dart';
import 'package:devotions_app/shared/blocs/token_bloc/token_bloc.dart';
import 'package:devotions_app/routing/main_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lyvepulse_components/blocs/paginated_bloc/paginated_event.dart';
import 'package:lyvepulse_components/blocs/paginated_bloc/paginated_state.dart';

/// The main page for viewing and managing activity notes.
class ActivityNotesPage extends StatefulWidget {
  /// Creates an activity notes page.
  const ActivityNotesPage({super.key});

  @override
  State<ActivityNotesPage> createState() => _ActivityNotesPageState();
}

class _ActivityNotesPageState extends State<ActivityNotesPage> {
  // Controller for search field
  final TextEditingController _searchController = TextEditingController();

  // Current filters
  Map<String, dynamic> _currentFilters = {};

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);

    // Ensure TokenCubit is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TokenCubit>().loadTokenAndBranch();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    // Debounce search input
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;

      final bloc = context.read<ActivityNoteBloc>();
      final tokenState = context.read<TokenCubit>().state;

      final filters = {
        'organizationId': tokenState.orgId ?? 0,
        'branchId': tokenState.branch ?? '',
        ..._currentFilters,
      };

      bloc.add(ApplyFiltersAndSorting(
        filters: filters,
        searchQuery: _searchController.text,
      ));
    });
  }

  Future<void> _showFilterDialog() async {
    // Example filter options for activity notes
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Activity Notes'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Date Range'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () {
                // Implement date range picker
              },
            ),
            ListTile(
              title: const Text('Note Type'),
              trailing: const Icon(Icons.note_alt_outlined),
              onTap: () {
                // Implement note type selection
              },
            ),
            ListTile(
              title: const Text('Created By'),
              trailing: const Icon(Icons.person_outline),
              onTap: () {
                // Implement user selection
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              // Return selected filters
              Navigator.pop(context, {
                // Add your filter values here
              });
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );

    if (result != null) {
      setState(() => _currentFilters = result);

      final bloc = context.read<ActivityNoteBloc>();
      final tokenState = context.read<TokenCubit>().state;

      final filters = {
        'organizationId': tokenState.orgId ?? 0,
        'branchId': tokenState.branch ?? '',
        ...result,
      };

      bloc.add(ApplyFiltersAndSorting(filters: filters));
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokenState = context.watch<TokenCubit>().state;
    final orgId = tokenState.orgId ?? 0;
    final branchId = tokenState.branch ?? '';

    return BlocProvider(
      create: (context) {
        final bloc = ActivityNoteBloc(
          repository: context.read<ActivityNoteRepository>(),
        );

        WidgetsBinding.instance.addPostFrameCallback((_) {
          bloc.add(ApplyFiltersAndSorting(
            filters: {'organizationId': orgId, 'branchId': branchId},
          ));
        });

        return bloc;
      },
      child: BlocListener<ActivityNoteBloc, PaginatedState>(
        listener: (context, state) {
          if (state is PaginatedFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                  label: 'Retry',
                  textColor: Colors.white,
                  onPressed: () {
                    context.read<ActivityNoteBloc>().add(
                          ApplyFiltersAndSorting(
                            filters: {
                              'organizationId': orgId,
                              'branchId': branchId,
                              ..._currentFilters,
                            },
                            searchQuery: _searchController.text,
                          ),
                        );
                  },
                ),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.grey.shade50,
          appBar: AppBar(
            title: Text(
              'Activity Notes',
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
              // Search action
              IconButton(
                icon: Icon(Icons.search_rounded, color: Colors.indigo.shade800),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: _ActivityNotesSearchDelegate(
                      searchController: _searchController,
                      onSearch: (query) {
                        final bloc = context.read<ActivityNoteBloc>();
                        bloc.add(
                          ApplyFiltersAndSorting(
                            filters: {
                              'organizationId': orgId,
                              'branchId': branchId,
                              ..._currentFilters,
                            },
                            searchQuery: query,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              // Filter action
              IconButton(
                icon: Icon(
                  Icons.filter_list_rounded,
                  color: Colors.indigo.shade800,
                ),
                onPressed: _showFilterDialog,
              ),
              // Refresh action
              IconButton(
                icon: Icon(Icons.refresh_rounded, color: Colors.indigo.shade800),
                onPressed: () {
                  final bloc = context.read<ActivityNoteBloc>();
                  bloc.add(
                    ApplyFiltersAndSorting(
                      filters: {
                        'organizationId': orgId,
                        'branchId': branchId,
                        ..._currentFilters,
                      },
                      searchQuery: _searchController.text,
                    ),
                  );
                },
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              final bloc = context.read<ActivityNoteBloc>();
              bloc.add(
                ApplyFiltersAndSorting(
                  filters: {
                    'organizationId': orgId,
                    'branchId': branchId,
                    ..._currentFilters,
                  },
                  searchQuery: _searchController.text,
                ),
              );
            },
            child: const ActivityNotesListView(),
          ),
          floatingActionButton: Builder(
            builder: (context) {
              return FloatingActionButton(
                onPressed: () async {
                  final bloc = context.read<ActivityNoteBloc>();
                  final currentTokenState = context.read<TokenCubit>().state;
                  final currentOrgId = currentTokenState.orgId ?? 0;
                  final currentBranchId = currentTokenState.branch ?? '';

                  final result = await context.push(AppRoutes.createActivityNote);

                  if (result == true) {
                    bloc.add(
                      ApplyFiltersAndSorting(
                        filters: {
                          'organizationId': currentOrgId,
                          'branchId': currentBranchId,
                          ..._currentFilters,
                        },
                        searchQuery: _searchController.text,
                      ),
                    );
                  }
                },
                backgroundColor: Colors.indigo.shade600,
                elevation: 2,
                child: const Icon(Icons.add, color: Colors.white),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Search delegate for activity notes search functionality
class _ActivityNotesSearchDelegate extends SearchDelegate<String> {
  final TextEditingController searchController;
  final Function(String) onSearch;

  _ActivityNotesSearchDelegate({
    required this.searchController,
    required this.onSearch,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          searchController.text = '';
          onSearch('');
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchController.text = query;
    onSearch(query);
    return const ActivityNotesListView();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement search suggestions if needed
    return Container();
  }
}