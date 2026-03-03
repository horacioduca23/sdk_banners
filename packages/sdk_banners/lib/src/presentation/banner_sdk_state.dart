import '../domain/models/banner_models.dart';

sealed class BannerSdkState {
  const BannerSdkState();

  const factory BannerSdkState.loading() = BannerSdkLoading;

  const factory BannerSdkState.data({
    required List<BannerSection> sections,
  }) = BannerSdkData;

  const factory BannerSdkState.empty() = BannerSdkEmpty;

  const factory BannerSdkState.error({
    required Object error,
    StackTrace? stackTrace,
  }) = BannerSdkError;
}

final class BannerSdkLoading extends BannerSdkState {
  const BannerSdkLoading();
}

final class BannerSdkData extends BannerSdkState {
  const BannerSdkData({
    required this.sections,
  });

  final List<BannerSection> sections;
}

final class BannerSdkEmpty extends BannerSdkState {
  const BannerSdkEmpty();
}

final class BannerSdkError extends BannerSdkState {
  const BannerSdkError({
    required this.error,
    this.stackTrace,
  });

  final Object error;
  final StackTrace? stackTrace;
}


