
import 'sdk_banners_platform_interface.dart';

class SdkBanners {
  Future<String?> getPlatformVersion() {
    return SdkBannersPlatform.instance.getPlatformVersion();
  }
}
