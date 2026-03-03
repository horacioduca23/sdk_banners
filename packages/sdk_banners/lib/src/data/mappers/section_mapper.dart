import 'package:flutter/widgets.dart' hide BannerLocation;

import '../../domain/models/banner_models.dart';
import '../dto/banner_dto.dart';
import '../dto/location_dto.dart';
import '../dto/section_dto.dart';

BannerLocation mapLocation(LocationDto dto) {
  return BannerLocation(id: dto.id, key: dto.key);
}

Color? _parseHexColor(String? hexString) {
  if (hexString == null) return null;
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

BannerItem mapBanner(BannerDto dto) {
  final parsedUrl = dto.openUrl == null ? null : Uri.tryParse(dto.openUrl!);
  return BannerItem(
    id: dto.id,
    imageUrl: dto.image,
    title: dto.title,
    description: dto.description,
    buttonText: dto.buttonText,
    openUrl: parsedUrl,
    containerColor: _parseHexColor(dto.containerColor),
    textColor: _parseHexColor(dto.textColor),
    designType: BannerDesignType.parse(dto.designType),
  );
}

BannerSection mapSection(SectionDto dto) {
  return BannerSection(
    id: dto.id,
    order: dto.order,
    title: dto.title,
    description: dto.description,
    viewMore: dto.viewMore,
    location: mapLocation(dto.location),
    banners: dto.banners.map(mapBanner).toList(growable: false),
  );
}
