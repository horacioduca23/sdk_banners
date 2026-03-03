import '../../domain/models/banner_models.dart';
import '../../domain/repositories/banner_repository.dart';
import '../api/banner_api_client.dart';
import '../mappers/section_mapper.dart';

/// Implementación HTTP del repositorio.
final class BannerRepositoryImpl implements BannerRepository {
  const BannerRepositoryImpl(this._apiClient);

  final BannerApiClient _apiClient;

  @override
  Future<List<BannerSection>> fetchSectionsByLocationKey({
    required String locationKey,
  }) async {
    final response = await _apiClient.fetchSections(locationKey: locationKey);
    return response.sections.map(mapSection).toList(growable: false);
  }
}


