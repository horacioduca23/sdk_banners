import 'package:flutter/material.dart';
import 'package:sdk_banners/sdk_banners.dart';

import 'src/channel/sdk_banners_host_channel.dart';

void main() => runApp(const SdkBannersModuleApp());

/// App raíz del Flutter Module.
///
/// El host nativo debería proveer `locationKey` y `baseUrl` via canal.\n+/// Para poder ejecutar con `flutter run` durante desarrollo, se usa un fallback.
class SdkBannersModuleApp extends StatefulWidget {
  const SdkBannersModuleApp({super.key});

  @override
  State<SdkBannersModuleApp> createState() => _SdkBannersModuleAppState();
}

class _SdkBannersModuleAppState extends State<SdkBannersModuleApp> {
  final _channel = SdkBannersHostChannel();
  SdkBannersConfig? _config;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    final config = await _channel.getConfig();
    if (!mounted) return;
    setState(() {
      _config = config ??
          SdkBannersConfig(
            locationKey: 'Home',
            baseUrl: Uri.parse('https://example.com'),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = _config;
    return MaterialApp(
      title: 'SDK Banners Module',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: config == null
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : Scaffold(
              appBar: AppBar(title: const Text('Banners')),
              body: BannerSdkView(
                locationKey: config.locationKey,
                baseUrl: config.baseUrl,
                actionHandler: (action) {
                  // Forward al host nativo.
                  // ignore: discarded_futures
                  _channel.emitAction(action);
                },
              ),
            ),
    );
  }
}
