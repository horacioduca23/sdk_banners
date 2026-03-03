import 'section_dto.dart';

class SectionsResponseDto {
  const SectionsResponseDto({
    required this.sections,
  });

  factory SectionsResponseDto.fromJson(Map<String, dynamic> json) {
    final sectionsJson = json['sections'] as List<dynamic>? ?? const [];
    return SectionsResponseDto(
      sections: sectionsJson
          .whereType<Map<String, dynamic>>()
          .map(SectionDto.fromJson)
          .toList(growable: false),
    );
  }

  final List<SectionDto> sections;
}


