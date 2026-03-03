# native_host_ios (placeholder)

Este directorio se usará para un ejemplo **nativo iOS** que embebe el Flutter
Module `modules/sdk_banners_module`.

## Objetivo

- Crear/usar un `FlutterEngine` (idealmente cacheado).
- Renderizar un `FlutterViewController` dentro del flujo nativo.
- Recibir acciones desde Flutter (por `MethodChannel`) para que el host decida
  qué hacer (V1: abrir una URL).

## Canal (Flutter -> iOS)

- **Channel name**: `sdk_banners_module/host`
- **Método**: `onAction`
- **Payload (Dictionary)**: ver [`modules/sdk_banners_module/README.md`](../../modules/sdk_banners_module/README.md)

## Ejemplo (Swift)

```swift
let engine = FlutterEngine(name: "sdk_banners_engine")
engine.run()

let channel = FlutterMethodChannel(
  name: "sdk_banners_module/host",
  binaryMessenger: engine.binaryMessenger
)

channel.setMethodCallHandler { call, result in
  switch call.method {
  case "getConfig":
    result(["locationKey": "Home", "baseUrl": "https://api.example.com"])
  case "onAction":
    if let payload = call.arguments as? [String: Any],
       let type = payload["type"] as? String {
      // type=open_url => abrir URL con UIApplication.shared.open(...)
    }
    result(nil)
  default:
    result(FlutterMethodNotImplemented)
  }
}
```

## Próximos pasos

1. Desde `modules/sdk_banners_module`, generar artefactos:
   - `flutter build ios-framework`
2. Integrar el framework en el proyecto iOS host.
3. Implementar engine + view controller y los canales.


