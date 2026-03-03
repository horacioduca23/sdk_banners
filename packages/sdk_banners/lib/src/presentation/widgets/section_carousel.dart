import 'package:flutter/material.dart';

import '../../domain/models/banner_models.dart';
import 'banner_card.dart';

class SectionCarousel extends StatelessWidget {
  const SectionCarousel({super.key, required this.section, required this.onBannerTap});

  final BannerSection section;
  final void Function(BannerItem banner) onBannerTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        padding: const EdgeInsets.only(right: 16),
        scrollDirection: Axis.horizontal,
        itemCount: section.banners.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final banner = section.banners[index];
          return BannerCard(
            imageUrl: banner.imageUrl,
            title: banner.title,
            description: banner.description,
            buttonText: banner.buttonText,
            containerColor: banner.containerColor,
            textColor: banner.textColor,
            designType: banner.designType,
            onTap: () => onBannerTap(banner),
          );
        },
      ),
    );
  }
}
