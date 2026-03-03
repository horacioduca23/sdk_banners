# sdk_banners (V1)

SDK de banners para Flutter basado en **Clean Architecture** y **Signals**.

## Qué hace (V1)

- Consume el endpoint `GET /locations/{locationKey}/sections`
- Renderiza secciones (título + descripción + “Ver más”) con carruseles horizontales
- Emite acciones hacia la app host:
  - `OpenUrlAction` (V1)
  - `ViewMoreAction` (V1)

## Contrato JSON (backend)

El SDK espera un response con forma:

```json
{
  "sections": [
    {
      "id": "sdfdsf1",
      "order": 1,
      "title": "titulo",
      "description": "descripcion opcional",
      "view_more": true,
      "location": { "id": "sdgsdg", "key": "Home" },
      "banners": [
        {
          "id": "b1",
          "image": "url",
          "title": "titulo opcional",
          "description": "description opcional",
          "button_text": "Ver más",
          "open_url": "link"
        }
      ]
    }
  ]
}
```

## Uso en app Flutter

```dart
BannerSdkView(
  locationKey: 'Home',
  baseUrl: Uri.parse('https://api.example.com'),
  actionHandler: (action) {
    switch (action) {
      case OpenUrlAction(:final url):
        // Abrir en navegador / in-app webview desde el host
        break;
      case ViewMoreAction(:final sectionId):
        // Navegar / mostrar pantalla del host
        break;
    }
  },
)
```

## State management (Signals)

La capa Presentation usa Signals (ver [`signals`](https://pub.dev/packages/signals)):\n+- El controller expone `state` como `Signal<BannerSdkState>`.\n+- El UI usa `Watch.builder` para redibujar en cambios de estado.\n+
