# native_host_android (placeholder)

Este directorio se usará para un ejemplo **nativo Android** que embebe el
Flutter Module `modules/sdk_banners_module`.

## Objetivo

- Iniciar un `FlutterEngine` (idealmente cacheado).
- Renderizar una `FlutterView` dentro de una pantalla nativa.
- Recibir acciones desde Flutter (por `MethodChannel`) para que el host decida
  qué hacer (V1: abrir una URL).

## Canal (Flutter -> Android)

- **Channel name**: `sdk_banners_module/host`
- **Método**: `onAction`
- **Payload (Map)**: ver [`modules/sdk_banners_module/README.md`](../../modules/sdk_banners_module/README.md)

## Ejemplo (Kotlin)

Este snippet muestra la idea general (sigue la guía oficial de add-to-app):

```kotlin
private val engine = FlutterEngine(context).apply {
  dartExecutor.executeDartEntrypoint(
    DartExecutor.DartEntrypoint.createDefault()
  )
}

MethodChannel(engine.dartExecutor.binaryMessenger, "sdk_banners_module/host")
  .setMethodCallHandler { call, result ->
    when (call.method) {
      "getConfig" -> result.success(
        mapOf("locationKey" to "Home", "baseUrl" to "https://api.example.com")
      )
      "onAction" -> {
        val payload = call.arguments as Map<*, *>
        // type=open_url => abrir URL con Intent
        result.success(null)
      }
      else -> result.notImplemented()
    }
  }
```

## Próximos pasos

1. Desde `modules/sdk_banners_module`, generar artefactos:
   - `flutter build aar`
2. Crear un Android app nativo y agregar el AAR como dependencia.
3. Implementar `FlutterEngine` + `FlutterView` y los canales.


