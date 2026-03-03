# SDK Banners Monorepo 🚀

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)

Solución integral y multiplataforma para la gestión y visualización de banners dinámicos. Este monorepo contiene el SDK core en Flutter, un módulo para integración nativa y ejemplos de implementación.

Android


<img width="430" height="985" alt="image" src="https://github.com/user-attachments/assets/e1520b1f-f4ab-4bb3-846a-7a33e44f91cb" />
<img width="429" height="956" alt="image" src="https://github.com/user-attachments/assets/75687238-1f76-4f82-b837-8456caf56d2d" />
<img width="442" height="991" alt="image" src="https://github.com/user-attachments/assets/0e6f7633-ee11-42ae-8b3a-c02feefabb68" />


---

## 📦 Estructura del Proyecto

### 1. SDK Core (Package)
Ubicación: `packages/sdk_banners`  
Es el corazón del proyecto. Proporciona los widgets y la lógica de negocio para renderizar banners.
- **Arquitectura**: Clean Architecture (Data, Domain, Presentation).
- **Manejo de Estado**: [Signals](https://pub.dev/packages/signals) para un reactividad eficiente.
- **UI Responsiva**: Los banners se adaptan automáticamente al tamaño de pantalla usando `MediaQuery` y `LayoutBuilder`.

### 2. Flutter Module (Add-to-App)
Ubicación: `modules/sdk_banners_module`  
Diseñado para ser integrado en aplicaciones nativas existentes (Android/iOS) como un módulo de Flutter.

### 3. Ejemplos (Host Applications)
Ubicación: `examples/`
- **`flutter_host_example`**: Aplicación Flutter completa que demuestra el uso del SDK con datos mockeados.
- **`native_host_android` / `ios`**: Esqueletos para integración en plataformas nativas.

---

## ✨ Características Principales

- **Diseños Dinámicos**: Soporte para tipos de diseño `IZQ` (Imagen izquierda) y `DER` (Imagen derecha) controlados desde el backend.
- **Personalización Total**: Control de colores de fondo (`container_color`) y texto (`text_color`) mediante códigos Hex.
- **Loader Premium**: Sistema de carga unificado (`BannerLoader`) con estética pulida y bordes redondeados.
- **Resiliencia**: Manejo elegante de errores y estados vacíos.

---

## 🚀 Instrucciones de Inicio Rápido

### Requisitos Previos
- Flutter SDK (>= 3.10.4)
- Dart SDK (>= 3.0.0)

### 1. Clonar y Preparar
```bash
git clone https://github.com/horacioduca23/sdk_banners.git
cd sdk_banners
```

### 2. Ejecutar Ejemplo Flutter
La mejor forma de ver el SDK en acción es mediante el ejemplo de host:
```bash
cd examples/flutter_host_example
flutter pub get
flutter run
```

### 3. Ejecutar Tests
Para asegurar la integridad de la lógica de negocio:
```bash
cd packages/sdk_banners
flutter test
```

---

## 🛠️ Uso del SDK (Básico)

```dart
BannerSdkView(
  locationKey: 'Home',
  baseUrl: Uri.parse('https://tu-api.com'),
  actionHandler: (action) {
    // Maneja acciones como OpenUrlAction o ViewMoreAction
  },
)
```

## 📝 Contrato del Backend (Mock)
El SDK espera un JSON con la siguiente estructura para los banners:

```json
{
  "id": "b1",
  "image": "url_de_la_imagen",
  "title": "Medios de pago",
  "description": "¡Conocé todas las opciones de ahorro!",
  "container_color": "#E91E63",
  "text_color": "#FFFFFF",
  "design_type": "IZQ"
}
```

---


Desarrollado con ❤️ por el equipo de **Think Up by Domus Global**.

