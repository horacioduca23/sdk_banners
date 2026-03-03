import 'package:flutter_test/flutter_test.dart';
import 'package:sdk_banners/sdk_banners.dart';
import 'package:sdk_banners/sdk_banners_platform_interface.dart';
import 'package:sdk_banners/sdk_banners_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSdkBannersPlatform
    with MockPlatformInterfaceMixin
    implements SdkBannersPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SdkBannersPlatform initialPlatform = SdkBannersPlatform.instance;

  test('$MethodChannelSdkBanners is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSdkBanners>());
  });

  test('getPlatformVersion', () async {
    SdkBanners sdkBannersPlugin = SdkBanners();
    MockSdkBannersPlatform fakePlatform = MockSdkBannersPlatform();
    SdkBannersPlatform.instance = fakePlatform;

    expect(await sdkBannersPlugin.getPlatformVersion(), '42');
  });
}
