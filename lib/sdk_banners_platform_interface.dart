import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'sdk_banners_method_channel.dart';

abstract class SdkBannersPlatform extends PlatformInterface {
  /// Constructs a SdkBannersPlatform.
  SdkBannersPlatform() : super(token: _token);

  static final Object _token = Object();

  static SdkBannersPlatform _instance = MethodChannelSdkBanners();

  /// The default instance of [SdkBannersPlatform] to use.
  ///
  /// Defaults to [MethodChannelSdkBanners].
  static SdkBannersPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SdkBannersPlatform] when
  /// they register themselves.
  static set instance(SdkBannersPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
