import 'package:devotions_app/shared/models/note_type_create_dto.dart';
import 'package:devotions_app/shared/models/note_type_read_dto.dart';
import 'package:devotions_app/shared/models/note_type_update_dto.dart';
import 'package:devotions_app/shared/models/page_note_type_read_dto.dart';

abstract class NoteTypeRepository {
  Future<PageNoteTypeReadDto> getAllNoteTypes({
    required int organizationId,
    required String branchId,
    int? page,
    int? pageSize,
    String? sortBy,
    String? sortDirection,
  });

  Future<NoteTypeReadDto> getNoteType(
    String id,
    String organizationId,
    String branchId,
  );

  Future<NoteTypeReadDto> createNoteType(
    NoteTypeCreateDto noteType,
    String organizationId,
    String branchId,
  );

  Future<NoteTypeReadDto> updateNoteType(
    String id,
    NoteTypeUpdateDto noteType,
    String organizationId,
    String branchId,
  );

  Future<void> deleteNoteType(
    String id,
    String organizationId,
    String branchId,
  );
}