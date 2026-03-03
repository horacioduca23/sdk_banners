import 'package:flutter/painting.dart';

// Modelos de dominio del SDK de banners.
//
// Estos modelos están desacoplados de la capa Data (DTOs / JSON) y se exponen
// como API pública para que el host pueda consumir y testear fácilmente.

/// Ubicación donde se debe renderizar una sección (por ejemplo: `Home`).
class BannerLocation {
  const BannerLocation({required this.id, required this.key});

  final String id;
  final String key;
}

/// Tipo de diseño del banner.
enum BannerDesignType {
  /// Imagen a la izquierda, texto a la derecha.
  left,

  /// Imagen a la derecha, texto a la izquierda.
  right;

  /// Parsea el valor desde el backend.
  factory BannerDesignType.parse(String? value) {
    if (value == 'DER') return BannerDesignType.right;
    return BannerDesignType.left;
  }
}

/// Un banner dentro de una sección.
class BannerItem {
  const BannerItem({
    required this.id,
    required this.imageUrl,
    this.title,
    this.description,
    this.buttonText,
    this.openUrl,
    this.containerColor,
    this.textColor,
    this.designType = BannerDesignType.left,
  });

  final String id;
  final String imageUrl;
  final String? title;
  final String? description;
  final String? buttonText;

  /// URL que debe abrirse al interactuar con el banner (V1).
  ///
  /// Puede ser `null` si el backend no configuró una acción.
  final Uri? openUrl;

  /// Color de fondo del contenedor del banner.
  final Color? containerColor;

  /// Color del texto del banner.
  final Color? textColor;

  /// Tipo de diseño del banner.
  final BannerDesignType designType;
}

/// Una sección (carrusel) de banners.
class BannerSection {
  const BannerSection({
    required this.id,
    required this.order,
    required this.title,
    required this.viewMore,
    required this.location,
    required this.banners,
    this.description,
  });

  final String id;
  final int order;
  final String title;
  final String? description;
  final bool viewMore;
  final BannerLocation location;
  final List<BannerItem> banners;
}
