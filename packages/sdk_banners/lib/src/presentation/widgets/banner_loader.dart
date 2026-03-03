import 'package:flutter/material.dart';

/// Un loader consistente y "premium" para todo el SDK.
///
/// Puede usarse en diferentes tamaños dependiendo del contexto
/// (ej: dentro de una card o en el centro de la pantalla).
class BannerLoader extends StatelessWidget {
  const BannerLoader({super.key, this.size = 24.0, this.strokeWidth = 3.0, this.color});

  /// Tamaño del loader (diámetro).
  final double size;

  /// Grosor de la línea del loader.
  final double strokeWidth;

  /// Color opcional del loader. Si es null, usa el color primario del tema.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          strokeCap: StrokeCap.round, // Bordes redondeados para un look premium
          valueColor: AlwaysStoppedAnimation<Color>(color ?? Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
