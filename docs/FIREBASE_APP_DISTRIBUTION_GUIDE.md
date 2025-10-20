# Firebase App Distribution – Guía paso a paso

## 1. Crear/Abrir Proyecto en Firebase Console

1. Accede a [Firebase Console](https://console.firebase.google.com/).
2. Crea un proyecto nuevo (ej.: `Taller1-Distribución`) o abre uno existente.
3. En el dashboard, selecciona tu proyecto.

## 2. Registrar la app Android

1. En el dashboard de Firebase, haz clic en **Add app** (o icono de Android).
2. Ingresa el **applicationId** de tu app: `com.taller.app.taller`
   - Puedes verificarlo en `android/app/build.gradle.kts`:
     ```kotlin
     applicationId = "com.taller.app.taller"
     ```
3. (Opcional) Nickname de la app: "Taller 1".
4. Descarga `google-services.json` **SOLO SI** necesitas servicios como Analytics, Firestore, etc. Para App Distribution es opcional.
5. Salta los pasos de SDK si solo usas App Distribution web.
6. Confirma el registro.

## 3. Configurar App Distribution → Testers & Groups

1. En el **menú lateral izquierdo** de Firebase Console, busca la sección **"Ejecución"** (segunda sección).
2. Haz clic en **"App Distribution"** (es la tercera opción bajo "Ejecución", justo después de "A/B Testing" y "AdMob").
3. Una vez dentro de App Distribution, verás pestañas en la parte superior.
4. Haz clic en la pestaña **"Testers & Groups"** (o "Evaluadores y grupos").
5. **Crear grupo**:
   - Clic en **"New Group"** o **"Crear grupo"**.
   - Nombre del grupo: `QA_Clase`.
   - Clic en **"Add testers"** o **"Agregar evaluadores"** e ingresa el correo: `dduran@uceva.edu.co`.
   - Confirmar y guardar el grupo.

## 4. Subir el APK (Release)

1. En **App Distribution**, busca la pestaña **"Releases"** (en la parte superior).
2. Clic en **"Distribute a release"** o **"Nueva versión"**.
3. **Drag and drop** o selecciona tu APK:
   - Ruta: `build/app/outputs/flutter-apk/app-release.apk`.
3. **Release notes** (ejemplo):
   ```
   Version: 1.0.1 (code 2)
   Date: 2025-10-20
   Changes:
   - Pantalla principal con contador y FAB
   - Permisos: INTERNET agregado
   - Estilos: color scheme por defecto
   QA:
   - Dispositivo: Pixel 6 (Android 14)
   - Resultado: OK, sin incidencias
   - Observaciones: N/A
   - Responsables: [Tu Nombre]
   ```
4. **Assign to groups**: selecciona `QA_Clase`.
5. Clic en **Distribute** para publicar.

## 5. Copiar enlace de instalación y verificar

1. Tras distribuir, verás un enlace de invitación en la pantalla de Releases o al hacer clic en los 3 puntos del release → **Copy installation link**.
2. Comparte el enlace con los testers (en este caso `dduran@uceva.edu.co` lo recibirá por correo automáticamente).
3. **Verificar**:
   - El tester recibe correo con botón **Download** o enlace.
   - Instalar en un dispositivo Android físico (habilitar **Fuentes desconocidas** si es necesario).
   - Abrir la app y probar funcionalidad básica.

## 6. Actualización incremental (1.0.1 → 1.0.2 ejemplo)

1. **Cambiar versión** en `pubspec.yaml`:
   ```yaml
   version: 1.0.2+3
   ```
2. **Rebuild APK**:
   ```bash
   flutter clean
   flutter build apk --release
   ```
3. **Subir nuevo release** en App Distribution:
   - Selecciona el nuevo APK (`app-release.apk` con version 1.0.2).
   - **Release notes** con cambios incrementales (ej.: "Fix botón, mejora UI").
   - Asigna al mismo grupo `QA_Clase`.
   - Distribuir.
4. **Evidencia**:
   - Captura de pantalla del panel Releases mostrando **antes** (1.0.1) y **después** (1.0.2).
   - Correo de actualización recibido por tester.
   - Foto de la app actualizada en dispositivo (verificar versión en Ajustes → Apps o en About de la app si lo implementaste).

## 7. Evidencias requeridas (PDF)

Capturar y compilar en un PDF:
- [ ] **Releases**: panel con nombre de versión visible (1.0.1, luego 1.0.2).
- [ ] **Testers**: captura mostrando `dduran@uceva.edu.co` en grupo `QA_Clase`.
- [ ] **Correo de invitación**: captura del correo recibido por un tester.
- [ ] **App instalada**: foto/captura de la app abierta en el dispositivo.
- [ ] **Actualización**: evidencia de antes/después (versión 1.0.1 → 1.0.2).
- [ ] **Bitácora de QA**: máx. 1 página con versión, fecha, cambios, incidencias, estado (usar `docs/QA_BITACORA_TEMPLATE.md`).
- [ ] **Primera página del PDF**: incluir URL del repositorio (https://github.com/GersainLeal/Taller1).

## 8. Bitácora de QA (ejemplo)

```markdown
# Bitácora de QA

- Versión: 1.0.1+2
- Fecha: 2025-10-20
- Cambios incluidos:
  - Pantalla principal: contador y FAB
  - Permisos: INTERNET agregado
- Casos verificados:
  - Apertura de la app
  - Interacción con FAB (incremento del contador)
  - Cierre y reapertura (persistencia de estado no requerida en este caso)
- Incidencias encontradas y resueltas:
  - Ninguna incidencia crítica
- Estado de pruebas: Aprobado
- Responsable(s): [Tu Nombre]
```

## 9. Pull Request y GitFlow

1. **Abrir PR** desde `feature/app_distribution` → `dev`:
   ```bash
   # En GitHub: ir a la rama feature/app_distribution y clic en "Compare & pull request"
   # Título: "feat: Firebase App Distribution setup and docs"
   # Descripción: mencionar cambios (version bump, permisos, docs, etc.)
   ```
2. **Revisión**: solicitar revisión de compañeros o auto-aprobación si es permitido.
3. **Merge a dev**: tras aprobación, hacer merge.
4. **Integrar a main**: desde `dev`, crear PR hacia `main` (o merge directo según política del equipo).

## 10. Comandos rápidos de resumen

```bash
# 1. Generar APK de release
flutter clean
flutter build apk --release

# 2. Localizar APK
# Windows:
build\app\outputs\flutter-apk\app-release.apk

# 3. Actualizar versión y rebuild
# Edita pubspec.yaml → version: x.y.z+n
flutter clean
flutter build apk --release

# 4. Commit y push
git add .
git commit -m "chore: bump version to x.y.z, update release notes"
git push -u origin feature/app_distribution

# 5. Abrir PR en GitHub hacia dev
```

## Recursos adicionales

- [Firebase App Distribution Docs](https://firebase.google.com/docs/app-distribution)
- [Flutter Build APK](https://docs.flutter.dev/deployment/android#build-an-apk)
- [Android Versioning](https://developer.android.com/studio/publish/versioning)

---

**¡Listo!** Con esta guía puedes completar todos los requisitos del taller: preparar el APK, configurar Firebase App Distribution, agregar testers, distribuir releases, evidenciar actualizaciones y documentar el proceso.
