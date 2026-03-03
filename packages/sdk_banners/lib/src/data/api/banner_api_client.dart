import 'dart:convert';

import 'package:http/http.dart' as http;

import '../dto/sections_response_dto.dart';

/// Cliente HTTP para el backend del SDK.
///
/// V1 (contrato): `GET /locations/{locationKey}/sections`.
final class BannerApiClient {
  BannerApiClient({
    required this.baseUrl,
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  final Uri baseUrl;
  final http.Client _httpClient;

  Uri _sectionsUri(String locationKey) {
    final base = baseUrl.toString().replaceAll(RegExp(r'/*$'), '');
    return Uri.parse('$base/locations/$locationKey/sections');
  }

  Future<SectionsResponseDto> fetchSections({
    required String locationKey,
  }) async {
    final uri = _sectionsUri(locationKey);
    final response = await _httpClient.get(uri);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(
        statusCode: response.statusCode,
        body: response.body,
      );
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Response JSON must be an object.');
    }

    return SectionsResponseDto.fromJson(decoded);
  }
}

/// Error simple para errores HTTP no-2xx.
final class HttpException implements Exception {
  const HttpException({
    required this.statusCode,
    required this.body,
  });

  final int statusCode;
  final String body;

  @override
  String toString() => 'HttpException(statusCode: $statusCode)';
}


