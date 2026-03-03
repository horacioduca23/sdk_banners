import 'package:flutter/material.dart';

import '../../domain/models/banner_models.dart';
import 'banner_loader.dart';

class BannerCard extends StatelessWidget {
  const BannerCard({
    super.key,
    required this.imageUrl,
    this.title,
    this.description,
    this.buttonText,
    required this.onTap,
    this.containerColor,
    this.textColor,
    this.designType = BannerDesignType.left,
  });

  final String imageUrl;
  final String? title;
  final String? description;
  final String? buttonText;
  final VoidCallback onTap;
  final Color? containerColor;
  final Color? textColor;
  final BannerDesignType designType;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.sizeOf(context);

    // Ancho dinámico: 85% de la pantalla, pero máximo 347px (según diseño aprobado).
    final cardWidth = (screenSize.width * 0.85).clamp(280.0, 347.0);

    final effectiveBgColor = containerColor ?? colorScheme.surfaceVariant;
    final effectiveTextColor = textColor ?? colorScheme.onSurfaceVariant;

    return SizedBox(
      width: cardWidth,
      child: Card(
        color: effectiveBgColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxHeight = constraints.maxHeight;

              // Escalamiento dinámico de fuentes según el alto disponible
              final titleSize = (maxHeight * 0.15).clamp(14.0, 18.0);
              final descSize = (maxHeight * 0.11).clamp(11.0, 13.0);
              final labelSize = (maxHeight * 0.10).clamp(10.0, 12.0);

              final imagePart = Expanded(
                flex: 45,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      color: Colors.black.withOpacity(0.05),
                      alignment: Alignment.center,
                      child: BannerLoader(size: 20, strokeWidth: 2, color: effectiveTextColor.withOpacity(0.3)),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.black.withOpacity(0.1),
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image_outlined, size: 20),
                    );
                  },
                ),
              );

              final textPart = Expanded(
                flex: 55,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (title != null)
                        Text(
                          title!,
                          style: textTheme.headlineSmall?.copyWith(color: effectiveTextColor, fontWeight: FontWeight.w900, fontSize: titleSize, height: 1.1),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      if (description != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          description!,
                          style: textTheme.titleMedium?.copyWith(color: effectiveTextColor.withOpacity(0.9), fontSize: descSize, height: 1.1),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      if (buttonText != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          buttonText!,
                          style: textTheme.labelLarge?.copyWith(
                            color: effectiveTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: labelSize,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );

              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: designType == BannerDesignType.left ? [imagePart, textPart] : [textPart, imagePart],
              );
            },
          ),
        ),
      ),
    );
  }
}
