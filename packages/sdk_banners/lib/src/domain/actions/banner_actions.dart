/// Acciones emitidas por el SDK hacia el host.
///
/// En V1 el SDK no ejecuta navegación ni abre URLs por sí mismo. En su lugar,
/// emite acciones para que la app host decida qué hacer.
sealed class BannerSdkAction {
  const BannerSdkAction();
}

/// Acción V1: abrir una URL.
final class OpenUrlAction extends BannerSdkAction {
  const OpenUrlAction({
    required this.url,
    required this.bannerId,
    required this.sectionId,
    required this.locationKey,
  });

  final Uri url;
  final String bannerId;
  final String sectionId;
  final String locationKey;
}

/// Acción de sección: el usuario tocó “Ver más”.
final class ViewMoreAction extends BannerSdkAction {
  const ViewMoreAction({
    required this.sectionId,
    required this.locationKey,
  });

  final String sectionId;
  final String locationKey;
}

/// Callback que debe proveer la app host para resolver acciones.
typedef BannerActionHandler = void Function(BannerSdkAction action);


