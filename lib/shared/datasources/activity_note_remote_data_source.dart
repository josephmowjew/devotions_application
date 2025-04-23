import 'package:devotions_app/shared/models/activity_note_create_dto.dart';
import 'package:devotions_app/shared/models/activity_note_filter_dto.dart';
import 'package:devotions_app/shared/models/activity_note_read_dto.dart';
import 'package:devotions_app/shared/models/activity_note_update_dto.dart';
import 'package:devotions_app/shared/models/paginated_activity_note_response.dart';

abstract class ActivityNoteRemoteDataSource {
  Future<PaginatedActivityNoteResponse> getAllActivityNotes({
    required int organizationId,
    required String branchId,
    int? page,
    int? pageSize,
    String? creatorEmail,
    List<String>? entityType,
    List<String>? entityId,
    List<String>? noteType,
    List<String>? creatorType,
    String? startDate,
    String? endDate,
    String? searchKeyword,
  });

  Future<ActivityNoteReadDto> getActivityNote(
    String id,
    String organizationId,
    String branchId,
  );

  Future<ActivityNoteReadDto> createActivityNote(
    ActivityNoteCreateDto activityNote,
    String organizationId,
    String branchId,
  );

  Future<ActivityNoteReadDto> updateActivityNote(
    String id,
    ActivityNoteUpdateDto activityNote,
    String organizationId,
    String branchId,
  );

  Future<void> deleteActivityNote(
    String id,
    String organizationId,
    String branchId,
  );

  Future<PaginatedActivityNoteResponse> filterActivityNotes(
    ActivityNoteFilterDto filter,
  );
}