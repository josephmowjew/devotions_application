import 'package:devotions_app/shared/datasources/note_type_remote_data_source.dart';
import 'package:devotions_app/shared/models/note_type_create_dto.dart';
import 'package:devotions_app/shared/models/note_type_read_dto.dart';
import 'package:devotions_app/shared/models/note_type_update_dto.dart';
import 'package:devotions_app/shared/models/page_note_type_read_dto.dart';
import 'package:devotions_app/shared/repositories/note_type_repository.dart';

class NoteTypeRepositoryImpl implements NoteTypeRepository {
  final NoteTypeRemoteDataSource remoteDataSource;

  NoteTypeRepositoryImpl(this.remoteDataSource);

  @override
  Future<PageNoteTypeReadDto> getAllNoteTypes({
    required int organizationId,
    required String branchId,
    int? page,
    int? pageSize,
    String? sortBy,
    String? sortDirection,
  }) {
    return remoteDataSource.getAllNoteTypes(
      organizationId: organizationId,
      branchId: branchId,
      page: page,
      pageSize: pageSize,
      sortBy: sortBy,
      sortDirection: sortDirection,
    );
  }

  @override
  Future<NoteTypeReadDto> getNoteType(
    String id,
    String organizationId,
    String branchId,
  ) {
    return remoteDataSource.getNoteType(id, organizationId, branchId);
  }

  @override
  Future<NoteTypeReadDto> createNoteType(
    NoteTypeCreateDto noteType,
    String organizationId,
    String branchId,
  ) {
    return remoteDataSource.createNoteType(noteType, organizationId, branchId);
  }

  @override
  Future<NoteTypeReadDto> updateNoteType(
    String id,
    NoteTypeUpdateDto noteType,
    String organizationId,
    String branchId,
  ) {
    return remoteDataSource.updateNoteType(id, noteType, organizationId, branchId);
  }

  @override
  Future<void> deleteNoteType(
    String id,
    String organizationId,
    String branchId,
  ) {
    return remoteDataSource.deleteNoteType(id, organizationId, branchId);
  }
}