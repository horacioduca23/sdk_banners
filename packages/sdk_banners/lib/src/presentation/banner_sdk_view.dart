import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:http/http.dart' as http;

import '../data/api/banner_api_client.dart';
import '../data/repositories/banner_repository_impl.dart';
import '../domain/actions/banner_actions.dart';
import '../domain/usecases/fetch_sections_by_location.dart';
import 'banner_sdk_controller.dart';
import 'banner_sdk_state.dart';
import 'widgets/section_carousel.dart';
import 'widgets/section_header.dart';
import 'widgets/banner_loader.dart';

/// Vista principal del SDK.
///
/// Renderiza secciones por `locationKey`, obtenidas desde el backend (V1).
/// Las interacciones se traducen en acciones hacia el host via [actionHandler].
class BannerSdkView extends StatefulWidget {
  const BannerSdkView({super.key, required this.locationKey, required this.baseUrl, required this.actionHandler, this.httpClient});

  /// Clave de ubicación (ejemplo: `Home`).
  final String locationKey;

  /// Base URL del backend (ejemplo: `https://api.miapp.com`).
  final Uri baseUrl;

  /// Handler que resuelve acciones (abrir URL, ver más, etc.).
  final BannerActionHandler actionHandler;

  /// Cliente HTTP opcional para tests o inyección desde el host.
  ///
  /// Si no se provee, el SDK crea un `http.Client` por defecto.
  final http.Client? httpClient;

  @override
  State<BannerSdkView> createState() => _BannerSdkViewState();
}

class _BannerSdkViewState extends State<BannerSdkView> with SignalsMixin {
  late final BannerSdkController _controller;

  @override
  void initState() {
    super.initState();
    final apiClient = BannerApiClient(baseUrl: widget.baseUrl, httpClient: widget.httpClient);
    final repo = BannerRepositoryImpl(apiClient);
    final useCase = FetchSectionsByLocation(repo);
    _controller = BannerSdkController(fetchSectionsByLocation: useCase, actionHandler: widget.actionHandler, locationKey: widget.locationKey);
    // ignore: discarded_futures
    _controller.load();
  }

  @override
  Widget build(BuildContext context) {
    return Watch.builder(
      builder: (context) {
        final state = _controller.state.value;
        return switch (state) {
          BannerSdkLoading() => const _LoadingView(),
          BannerSdkEmpty() => const _EmptyView(),
          BannerSdkError() => _ErrorView(onRetry: _controller.retry),
          BannerSdkData(:final sections) => ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: sections.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              final section = sections[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(
                    title: section.title,
                    description: section.description,
                    showViewMore: section.viewMore,
                    onViewMore: () => _controller.onViewMoreTap(section),
                  ),
                  const SizedBox(height: 12),
                  SectionCarousel(
                    section: section,
                    onBannerTap: (banner) => _controller.onBannerTap(section: section, banner: banner),
                  ),
                ],
              );
            },
          ),
        };
      },
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const BannerLoader(size: 32);
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('No hay banners para mostrar.'));
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Ocurrió un error al cargar los banners.'),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: onRetry, child: const Text('Reintentar')),
          ],
        ),
      ),
    );
  }
}
