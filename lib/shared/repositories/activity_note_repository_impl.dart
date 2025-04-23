import 'package:devotions_app/shared/datasources/activity_note_remote_data_source.dart';
import 'package:devotions_app/shared/models/activity_note_create_dto.dart';
import 'package:devotions_app/shared/models/activity_note_filter_dto.dart';
import 'package:devotions_app/shared/models/activity_note_read_dto.dart';
import 'package:devotions_app/shared/models/activity_note_update_dto.dart';
import 'package:devotions_app/shared/models/paginated_activity_note_response.dart';
import 'package:devotions_app/shared/repositories/activity_note_repository.dart';

class ActivityNoteRepositoryImpl implements ActivityNoteRepository {
  final ActivityNoteRemoteDataSource remoteDataSource;

  ActivityNoteRepositoryImpl(this.remoteDataSource);

  @override
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
  }) {
    return remoteDataSource.getAllActivityNotes(
      organizationId: organizationId,
      branchId: branchId,
      page: page,
      pageSize: pageSize,
      creatorEmail: creatorEmail,
      entityType: entityType,
      entityId: entityId,
      noteType: noteType,
      creatorType: creatorType,
      startDate: startDate,
      endDate: endDate,
      searchKeyword: searchKeyword,
    );
  }

  @override
  Future<ActivityNoteReadDto> getActivityNote(
    String id,
    String organizationId,
    String branchId,
  ) {
    return remoteDataSource.getActivityNote(id, organizationId, branchId);
  }

  @override
  Future<ActivityNoteReadDto> createActivityNote(
    ActivityNoteCreateDto activityNote,
    String organizationId,
    String branchId,
  ) {
    return remoteDataSource.createActivityNote(activityNote, organizationId, branchId);
  }

  @override
  Future<ActivityNoteReadDto> updateActivityNote(
    String id,
    ActivityNoteUpdateDto activityNote,
    String organizationId,
    String branchId,
  ) {
    return remoteDataSource.updateActivityNote(id, activityNote, organizationId, branchId);
  }

  @override
  Future<void> deleteActivityNote(
    String id,
    String organizationId,
    String branchId,
  ) {
    return remoteDataSource.deleteActivityNote(id, organizationId, branchId);
  }

  @override
  Future<PaginatedActivityNoteResponse> filterActivityNotes(
    ActivityNoteFilterDto filter,
  ) {
    return remoteDataSource.filterActivityNotes(filter);
  }
}