import 'note_type_read_dto.dart';
import 'pageable_object.dart';
import 'sort_object.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class PageNoteTypeReadDto {
  final int? totalElements;
  final int? totalPages;
  final int? size;
  final List<NoteTypeReadDto>? content;
  final int? number;
  final SortObject? sort;
  final PageableObject? pageable;
  final int? numberOfElements;
  final bool? first;
  final bool? last;
  final bool? empty;

  const PageNoteTypeReadDto({
    this.totalElements,
    this.totalPages,
    this.size,
    this.content,
    this.number,
    this.sort,
    this.pageable,
    this.numberOfElements,
    this.first,
    this.last,
    this.empty,
  });

  factory PageNoteTypeReadDto.fromJson(Map<String, dynamic> json) => PageNoteTypeReadDto(
        totalElements: json['totalElements'] as int?,
        totalPages: json['totalPages'] as int?,
        size: json['size'] as int?,
        content: (json['content'] as List<dynamic>?)
            ?.map((e) => NoteTypeReadDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        number: json['number'] as int?,
        sort: json['sort'] == null ? null : SortObject.fromJson(json['sort'] as Map<String, dynamic>),
        pageable: json['pageable'] == null
            ? null
            : PageableObject.fromJson(json['pageable'] as Map<String, dynamic>),
        numberOfElements: json['numberOfElements'] as int?,
        first: json['first'] as bool?,
        last: json['last'] as bool?,
        empty: json['empty'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        if (totalElements != null) 'totalElements': totalElements,
        if (totalPages != null) 'totalPages': totalPages,
        if (size != null) 'size': size,
        if (content != null) 'content': content!.map((e) => e.toJson()).toList(),
        if (number != null) 'number': number,
        if (sort != null) 'sort': sort!.toJson(),
        if (pageable != null) 'pageable': pageable!.toJson(),
        if (numberOfElements != null) 'numberOfElements': numberOfElements,
        if (first != null) 'first': first,
        if (last != null) 'last': last,
        if (empty != null) 'empty': empty,
      };
}