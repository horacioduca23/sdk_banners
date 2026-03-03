import 'package:signals/signals.dart';

import '../domain/actions/banner_actions.dart';
import '../domain/models/banner_models.dart';
import '../domain/usecases/fetch_sections_by_location.dart';
import 'banner_sdk_state.dart';

/// Controller/ViewModel del SDK.
///
/// Usa Signals para exponer el estado de forma reactiva al UI.
final class BannerSdkController {
  BannerSdkController({
    required FetchSectionsByLocation fetchSectionsByLocation,
    required BannerActionHandler actionHandler,
    required String locationKey,
  })  : _fetchSectionsByLocation = fetchSectionsByLocation,
        _actionHandler = actionHandler,
        _locationKey = locationKey,
        state = signal<BannerSdkState>(const BannerSdkState.loading());

  final FetchSectionsByLocation _fetchSectionsByLocation;
  final BannerActionHandler _actionHandler;
  final String _locationKey;

  final Signal<BannerSdkState> state;

  List<BannerSection> get sections {
    final current = state.value;
    return switch (current) {
      BannerSdkData(:final sections) => sections,
      _ => const <BannerSection>[],
    };
  }

  Future<void> load() async {
    state.value = const BannerSdkState.loading();
    try {
      final sections = await _fetchSectionsByLocation(locationKey: _locationKey);
      if (sections.isEmpty) {
        state.value = const BannerSdkState.empty();
        return;
      }
      state.value = BannerSdkState.data(sections: sections);
    } catch (e, s) {
      state.value = BannerSdkState.error(error: e, stackTrace: s);
    }
  }

  void retry() {
    // ignore: discarded_futures
    load();
  }

  void onViewMoreTap(BannerSection section) {
    if (!section.viewMore) return;
    _actionHandler(
      ViewMoreAction(sectionId: section.id, locationKey: section.location.key),
    );
  }

  void onBannerTap({
    required BannerSection section,
    required BannerItem banner,
  }) {
    final url = banner.openUrl;
    if (url == null) return;
    _actionHandler(
      OpenUrlAction(
        url: url,
        bannerId: banner.id,
        sectionId: section.id,
        locationKey: section.location.key,
      ),
    );
  }
}


