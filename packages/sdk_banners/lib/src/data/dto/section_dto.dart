import 'banner_dto.dart';
import 'location_dto.dart';

class SectionDto {
  const SectionDto({
    required this.id,
    required this.order,
    required this.title,
    required this.viewMore,
    required this.location,
    required this.banners,
    this.description,
  });

  factory SectionDto.fromJson(Map<String, dynamic> json) {
    final bannersJson = json['banners'] as List<dynamic>? ?? const [];
    return SectionDto(
      id: json['id'] as String,
      order: (json['order'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      viewMore: json['view_more'] as bool? ?? false,
      location: LocationDto.fromJson(json['location'] as Map<String, dynamic>),
      banners: bannersJson
          .whereType<Map<String, dynamic>>()
          .map(BannerDto.fromJson)
          .toList(growable: false),
    );
  }

  final String id;
  final int order;
  final String title;
  final String? description;
  final bool viewMore;
  final LocationDto location;
  final List<BannerDto> banners;
}


