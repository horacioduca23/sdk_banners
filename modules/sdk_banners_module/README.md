# sdk_banners_module

Flutter Module para embeber el SDK `sdk_banners` en apps nativas Android/iOS.

## Getting Started

Este module renderiza el widget `BannerSdkView` y reenvía las acciones al host
nativo mediante `MethodChannel`.

## Canal con el host nativo

- **Channel name**: `sdk_banners_module/host`
- **Métodos**
  - `getConfig` (host -> Flutter): devuelve un `Map` con:
    - `locationKey`: `String`
    - `baseUrl`: `String`
  - `onAction` (Flutter -> host): recibe un `Map` con:
    - `type`: `open_url` | `view_more`
    - `locationKey`: `String`
    - `sectionId`: `String`
    - `bannerId`: `String` (solo `open_url`)
    - `url`: `String` (solo `open_url`)

## Standalone (desarrollo)

Si corrés el module con `flutter run` sin un host nativo, el `getConfig` se
ignora y se usa un fallback (`locationKey: Home`, `baseUrl: https://example.com`).
