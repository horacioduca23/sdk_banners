class BannerDto {
  const BannerDto({
    required this.id,
    required this.image,
    this.title,
    this.description,
    this.buttonText,
    this.openUrl,
    this.containerColor,
    this.textColor,
    this.designType,
  });

  factory BannerDto.fromJson(Map<String, dynamic> json) {
    return BannerDto(
      id: json['id'] as String,
      image: json['image'] as String,
      title: json['title'] as String?,
      description: json['description'] as String?,
      buttonText: json['button_text'] as String?,
      openUrl: json['open_url'] as String?,
      containerColor: json['container_color'] as String?,
      textColor: json['text_color'] as String?,
      designType: json['design_type'] as String?,
    );
  }

  final String id;
  final String image;
  final String? title;
  final String? description;
  final String? buttonText;
  final String? openUrl;
  final String? containerColor;
  final String? textColor;
  final String? designType;
}
