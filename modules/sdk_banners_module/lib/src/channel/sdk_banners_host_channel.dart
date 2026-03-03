import 'dart:async';

import 'package:flutter/services.dart';

import 'package:sdk_banners/sdk_banners.dart';

/// Contrato de comunicación Flutter Module <-> Host nativo.
///
/// - El host puede proveer configuración inicial via `getConfig`.
/// - El module emite acciones via `onAction`.
///
/// V1: se emiten `open_url` y `view_more`.
final class SdkBannersHostChannel {
  SdkBannersHostChannel({
    MethodChannel? channel,
  }) : _channel = channel ?? const MethodChannel(_channelName);

  static const String _channelName = 'sdk_banners_module/host';

  final MethodChannel _channel;

  Future<SdkBannersConfig?> getConfig() async {
    Object? result;
    try {
      result = await _channel
          .invokeMethod<Object?>('getConfig')
          .timeout(const Duration(milliseconds: 250));
    } on MissingPluginException {
      // El module puede ejecutarse standalone (flutter run) sin host nativo.
      // En ese caso, no existe implementación del channel: devolvemos null.
      return null;
    } on TimeoutException {
      return null;
    } on PlatformException {
      return null;
    } catch (_) {
      return null;
    }
    if (result is! Map) return null;

    final map = Map<String, Object?>.from(result);
    final locationKey = map['locationKey'] as String?;
    final baseUrl = map['baseUrl'] as String?;
    if (locationKey == null || baseUrl == null) return null;

    final parsed = Uri.tryParse(baseUrl);
    if (parsed == null) return null;

    return SdkBannersConfig(
      locationKey: locationKey,
      baseUrl: parsed,
    );
  }

  Future<void> emitAction(BannerSdkAction action) async {
    final payload = switch (action) {
      OpenUrlAction(
        :final url,
        :final bannerId,
        :final sectionId,
        :final locationKey,
      ) =>
        <String, Object?>{
          'type': 'open_url',
          'url': url.toString(),
          'bannerId': bannerId,
          'sectionId': sectionId,
          'locationKey': locationKey,
        },
      ViewMoreAction(:final sectionId, :final locationKey) => <String, Object?>{
          'type': 'view_more',
          'sectionId': sectionId,
          'locationKey': locationKey,
        },
    };

    try {
      await _channel.invokeMethod<void>('onAction', payload);
    } on MissingPluginException {
      // Standalone mode: no host nativo para recibir la acción.
    } on PlatformException {
      // El host nativo puede decidir no implementar `onAction` aún.
    } catch (_) {
      // Ignorado intencionalmente: el host puede estar ausente o no disponible.
    }
  }
}

/// Configuración mínima que el host nativo puede inyectar al module.
final class SdkBannersConfig {
  const SdkBannersConfig({
    required this.locationKey,
    required this.baseUrl,
  });

  final String locationKey;
  final Uri baseUrl;
}


