import '../models/banner_models.dart';

/// Repositorio de banners/sections.
///
/// Abstrae la fuente de datos (HTTP/cache/mock) para mantener el dominio
/// independiente y testeable.
abstract interface class BannerRepository {
  Future<List<BannerSection>> fetchSectionsByLocationKey({
    required String locationKey,
  });
}


