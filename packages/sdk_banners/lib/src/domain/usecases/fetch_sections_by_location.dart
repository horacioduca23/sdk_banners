import '../models/banner_models.dart';
import '../repositories/banner_repository.dart';

/// Caso de uso: obtiene secciones por `locationKey` y aplica reglas de dominio.
final class FetchSectionsByLocation {
  const FetchSectionsByLocation(this._repository);

  final BannerRepository _repository;

  Future<List<BannerSection>> call({
    required String locationKey,
  }) async {
    final sections =
        await _repository.fetchSectionsByLocationKey(locationKey: locationKey);

    final filtered = sections
        .where((s) => s.location.key == locationKey)
        .toList(growable: false);

    filtered.sort((a, b) => a.order.compareTo(b.order));
    return filtered;
  }
}


