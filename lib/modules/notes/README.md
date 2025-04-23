# Activity Notes Module

A reusable Flutter UI module for displaying paginated activity notes with search and filter capabilities. This module is designed to work seamlessly with BLoC pattern and provides a clean, modern interface for displaying activity notes.

![Activity Notes Module](../../assets/activity_notes_preview.png)

## Directory Structure

```
lib/modules/notes/
├── activity_notes.dart      # Main widget
├── activity_note.dart       # Single note widget
├── components/
│   ├── activity_search.dart # Search component
│   ├── activity_item.dart   # List item component
│   └── add_note_section.dart# Add note component
├── models/
│   └── activity.dart        # Activity model
└── utils/
    └── theme_constants.dart # Theme constants
```

## Quick Start

1. Import the module:
```dart
import 'package:flutter_ui_modules/modules/notes/activity_notes.dart';
```

2. Use it in your BLoC-based widget:
```dart
ActivityNotes(
  activities: activities,
  isLoading: false,
  hasReachedMax: false,
  totalItems: activities.length,
  onSearch: (query) => handleSearch(query),
  onFilter: () => handleFilter(),
  onAddNote: (note) => handleAddNote(note),
  scrollController: _scrollController,
)
```

## Integration with BLoC

### Required BLoC Dependencies

```yaml
dependencies:
  flutter_bloc: ^8.1.3
  lyvepulse_components:
    git:
      url: https://github.com/your-repository/lyvepulse_components.git
```

### BLoC Implementation

Your BLoC should extend `PaginatedBloc<Activity>`:

```dart
class ActivityBloc extends PaginatedBloc<Activity> {
  final ActivityRepository repository;
  static const int pageSize = 10;

  ActivityBloc({required this.repository}) : super();

  @override
  Future<Pair<int, List<Activity>>> fetchPage({
    required int page,
    required Map<String, dynamic> filters,
    String? searchQuery,
    String? sortField,
    bool ascending = true,
  }) async {
    final response = await repository.getActivities(
      page: page,
      pageSize: pageSize,
      search: searchQuery,
      filters: filters,
    );
    return Pair(response.totalCount, response.items);
  }
}
```

### Events

Define your events in `activity_bloc.dart`:

```dart
abstract class ActivityEvent {}

class LoadActivities extends ActivityEvent {}
class LoadMoreActivities extends ActivityEvent {}
class ActivitySearchEvent extends ActivityEvent {
  final String searchQuery;
  ActivitySearchEvent({required this.searchQuery});
}
class ActivityFilterEvent extends ActivityEvent {}
class ActivityAddNoteEvent extends ActivityEvent {
  final String note;
  ActivityAddNoteEvent({required this.note});
}
```

### Complete Integration Example

```dart
class ActivityPage extends StatefulWidget {
  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final ScrollController _scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    _setupScrollController();
  }

  void _setupScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8) {
        final bloc = context.read<ActivityBloc>();
        if (!(bloc.state is PaginatedLoading) && !bloc.state.hasReachedMax) {
          bloc.add(LoadMoreActivities());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivityBloc(
        repository: context.read<ActivityRepository>(),
      )..add(LoadActivities()),
      child: BlocBuilder<ActivityBloc, PaginatedState<Activity>>(
        builder: (context, state) {
          return ActivityNotes(
            activities: state.items,
            isLoading: state is PaginatedLoading,
            hasReachedMax: state.hasReachedMax,
            totalItems: state.totalItems,
            error: state is PaginatedFailure ? state.error : null,
            onSearch: (query) => context.read<ActivityBloc>().add(
              ActivitySearchEvent(searchQuery: query),
            ),
            onFilter: () => context.read<ActivityBloc>().add(
              ActivityFilterEvent(),
            ),
            onAddNote: (note) => context.read<ActivityBloc>().add(
              ActivityAddNoteEvent(note: note),
            ),
            scrollController: _scrollController,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
```

## Activity Model

The module expects activities to follow this model:

```dart
class Activity {
  final String id;
  final String title;
  final String description;
  final String user;
  final DateTime timestamp;

  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.user,
    required this.timestamp,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      user: json['user'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
```

## Props Reference

| Prop | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| activities | List<Activity> | Yes | - | List of activities to display |
| onSearch | Function(String) | Yes | - | Called when search query changes |
| onFilter | VoidCallback | Yes | - | Called when filter button is pressed |
| onAddNote | Function(String)? | No | null | Called when a note is added |
| width | double? | No | null | Custom width for the card |
| height | double? | No | null | Custom height for the card |
| isLoading | bool | No | false | Loading state indicator |
| hasReachedMax | bool | No | false | Indicates if all items are loaded |
| totalItems | int | No | 0 | Total number of items available |
| error | String? | No | null | Error message to display |
| scrollController | ScrollController? | No | null | Controller for pagination |

## Customization

### Theme Constants

You can override the default theme by creating your own `theme_constants.dart`:

```dart
class ActivityNotesTheme {
  static const searchBackground = Color(0xFFF5F5F5);
  static const searchBorderRadius = 8.0;
  static const searchIconColor = Color(0xFF6E7191);
  static const titleText = Color(0xFF0B1F44);
  static const dividerColor = Color(0xFFE0E0E0);
}
```

## Common Issues

1. **Pagination not working**
   - Ensure `scrollController` is properly set up
   - Check if `hasReachedMax` is being updated correctly

2. **Search not updating**
   - Verify `onSearch` callback is properly connected to BLoC
   - Check if search event is being handled in BLoC

3. **Loading state not showing**
   - Confirm `isLoading` is being updated from BLoC state
   - Verify PaginatedLoading state is being emitted

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request 