import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:sdk_banners/sdk_banners.dart';

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SDK Banners Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo), useMaterial3: true),
      home: const DemoHome(),
    );
  }
}

class DemoHome extends StatelessWidget {
  const DemoHome({super.key});

  static const locationKey = 'Home';

  @override
  Widget build(BuildContext context) {
    final mockClient = MockClient((request) async {
      if (request.method == 'GET' && request.url.path.endsWith('/locations/$locationKey/sections')) {
        return http.Response(jsonEncode(_mockResponse), 200);
      }
      return http.Response('Not Found', 404);
    });

    return Scaffold(
      appBar: AppBar(title: const Text('SDK Banners (V1)')),
      body: BannerSdkView(
        locationKey: locationKey,
        baseUrl: Uri.parse('https://example.com'),
        httpClient: mockClient,
        actionHandler: (action) {
          final message = switch (action) {
            OpenUrlAction(:final url) => 'OpenUrl: $url',
            ViewMoreAction(:final sectionId) => 'ViewMore: $sectionId',
          };
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
        },
      ),
    );
  }
}

const Map<String, Object?> _mockResponse = {
  "sections": [
    {
      "id": "sdfdsf2",
      "order": 1,
      "title": "Promociones Exclusivas",
      "description": "Aprovechá los mejores descuentos del día",
      "view_more": true,
      "location": {"id": "sdgsdg", "key": "Home"},
      "banners": [
        {
          "id": "b1",
          "image": "https://img.freepik.com/free-photo/hand-holding-credit-card-with-smart-phone-shopping-online_1423-83.jpg",
          "title": "Medios de pago",
          "description": "¡Conocé todas las opciones de ahorro!",
          "open_url": "https://example.com/b1",
          "container_color": "#E91E63",
          "text_color": "#FFFFFF",
          "design_type": "IZQ",
        },
        {
          "id": "b2",
          "image": "https://img.freepik.com/free-photo/fresh-vegetables-bag_23-2148184646.jpg",
          "title": "Mercados",
          "description": "¡Conocé las promos y ahorrá!",
          "open_url": "https://example.com/b2",
          "container_color": "#2962FF",
          "text_color": "#FFFFFF",
          "design_type": "DER",
        },
        {
          "id": "b3",
          "image": "https://img.freepik.com/free-photo/sushi-set-table_23-2148123241.jpg",
          "title": "Restaurantes",
          "description": "¡Disfrutá estas promociones!",
          "open_url": "https://example.com/b3",
          "container_color": "#FFEE58",
          "text_color": "#212121",
          "design_type": "DER",
        },
      ],
    },
  ],
};
