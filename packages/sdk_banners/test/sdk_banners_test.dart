import 'package:flutter_test/flutter_test.dart';
import 'package:sdk_banners/src/data/dto/sections_response_dto.dart';
import 'package:sdk_banners/src/domain/models/banner_models.dart';
import 'package:sdk_banners/src/domain/repositories/banner_repository.dart';
import 'package:sdk_banners/src/domain/usecases/fetch_sections_by_location.dart';

void main() {
  test('parsing contrato JSON: sections wrapper', () {
    final dto = SectionsResponseDto.fromJson(_mockResponse);
    expect(dto.sections, hasLength(2));
    expect(dto.sections.first.viewMore, true);
    expect(dto.sections.first.banners.first.openUrl, isNotNull);
  });

  test('use case: filtra por locationKey y ordena por order', () async {
    final useCase = FetchSectionsByLocation(_FakeRepository());

    final sections = await useCase(locationKey: 'Home');
    expect(sections, hasLength(2));
    expect(sections.first.order, 1);
    expect(sections.last.order, 2);
    expect(sections.every((s) => s.location.key == 'Home'), true);
  });
}

final class _FakeRepository implements BannerRepository {
  @override
  Future<List<BannerSection>> fetchSectionsByLocationKey({
    required String locationKey,
  }) async {
    return const [
      BannerSection(
        id: 's2',
        order: 2,
        title: 't2',
        description: null,
        viewMore: true,
        location: BannerLocation(id: 'l1', key: 'Home'),
        banners: [],
      ),
      BannerSection(
        id: 's1',
        order: 1,
        title: 't1',
        description: null,
        viewMore: true,
        location: BannerLocation(id: 'l1', key: 'Home'),
        banners: [],
      ),
      BannerSection(
        id: 'sOther',
        order: 0,
        title: 'other',
        description: null,
        viewMore: true,
        location: BannerLocation(id: 'l2', key: 'Other'),
        banners: [],
      ),
    ];
  }
}

const Map<String, Object?> _mockResponse = {
  'sections': [
    {
      'id': 'sdfdsf1',
      'order': 1,
      'title': 'titulo',
      'description': 'descripcion opcional',
      'view_more': true,
      'location': {'id': 'sdgsdg', 'key': 'Home'},
      'banners': [
        {
          'id': 'b1',
          'image': 'url',
          'title': 'titulo opcional',
          'description': 'description opcional',
          'button_text': 'Ver más',
          'open_url': 'https://example.com/b1',
        },
      ],
    },
    {
      'id': 'sdfdsf2',
      'order': 2,
      'title': 'titulo 2 ',
      'description': 'descripcion opcional2',
      'view_more': true,
      'location': {'id': 'sdgsdg', 'key': 'Home'},
      'banners': [
        {
          'id': 'b2',
          'image': 'url',
          'title': 'titulo opcional 2',
          'description': 'description opcional2',
          'button_text': 'Ver más',
          'open_url': 'https://example.com/b2',
        },
      ],
    },
  ],
};
