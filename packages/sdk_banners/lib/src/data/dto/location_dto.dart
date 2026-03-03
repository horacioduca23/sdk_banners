class LocationDto {
  const LocationDto({
    required this.id,
    required this.key,
  });

  factory LocationDto.fromJson(Map<String, dynamic> json) {
    return LocationDto(
      id: json['id'] as String,
      key: json['key'] as String,
    );
  }

  final String id;
  final String key;
}


