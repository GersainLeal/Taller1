# Taller 1 – Distribución con Firebase App Distribution

Este repo contiene la app Flutter y el flujo para preparar APKs y distribuirlos vía Firebase App Distribution.

Repositorio: rama de trabajo `feature/app_distribution` a partir de `dev` y PR hacia `dev`.

## Flujo de publicación

1) Generar APK de release
- Asegúrate de tener una versión válida en `pubspec.yaml` (formato `x.y.z+build`).
- Ejecuta: `flutter clean` y luego `flutter build apk`.
- El APK quedará en `build/app/outputs/flutter-apk/app-release.apk`.

2) App Distribution → Testers → Instalación
- En Firebase Console, crea/abre el proyecto y registra la app Android con tu `applicationId` (`com.taller.app.taller`).
- App Distribution > Testers & Groups: crea grupo `QA_Clase` y agrega `dduran@uceva.edu.co`.
- App Distribution > Releases: sube `app-release.apk` y asígnalo a `QA_Clase`.
- Agrega Release Notes con cambios y credenciales (si aplica) y distribuye.
- Copia el enlace de instalación y compártelo con testers.

3) Actualización
- Incrementa la versión en `pubspec.yaml` (ej.: `1.0.1+2` → `1.0.2+3`).
- Vuelve a construir y distribuir, evidenciando antes/después en Releases.

## Notas de versionado
- Flutter usa `version: <build-name>+<build-number>` en `pubspec.yaml`.
- Android toma `build-name` como `versionName` y `build-number` como `versionCode`.
- Ejemplo actual: `1.0.1+2`.

## Formato de Release Notes sugerido
- Versión: 1.0.1 (code 2)
- Fecha: 2025-10-20
- Cambios:
	- Pantalla principal: contador y FAB (+1)
	- Estilos: esquema de color por defecto
- QA:
	- Dispositivo: Pixel 6 (Android 14)
	- Resultado: OK, sin incidencias críticas
	- Observaciones: N/A
	- Responsables: Nombre Apellido

## Bitácora breve de QA (ejemplo)
- Versión: 1.0.1+2 – 2025-10-20
- Casos probados: apertura, interacción con FAB, cierre/reapertura
- Incidencias: ninguna
- Estado: Aprobado para QA_Clase

## GitFlow rápido
- Crear rama: `git checkout -b feature/app_distribution origin/dev`
- Commit/push cambios y abrir PR hacia `dev`.
- Tras revisión: merge a `dev` y posteriormente integrar a `main`.

## Requisitos técnicos verificados
- Permisos mínimos en Android: `INTERNET` en `android/app/src/main/AndroidManifest.xml`.
- Versionado coherente en `pubspec.yaml`.

## Cómo replicar
- Instala Flutter estable y ejecuta:
	- `flutter pub get`
	- `flutter build apk`
- Sube a Firebase App Distribution siguiendo la sección “Flujo de publicación”.
