# Taller: navegación con go_router, widgets y ciclo de vida

## URL del repositorio
(poner aquí la URL pública del repo)

## Arquitectura / Rutas
Rutas definidas (GoRouter):
- `/` (home) — HomeScreen con GridView y botones para `go`, `push`, `replace`.
- `/detail/:message` — DetailScreen (muestra parámetro `message`).
- `/tabs` — TabsScreen (TabBar con Grid, ThirdWidget y Info).

Parámetros: se pasa `message` por la ruta (`/detail/<message>`). Se codifica con `Uri.encodeComponent(...)` y se decodifica en el destino.

## Widgets usados y porqué
- **GridView**: para mostrar rápido una colección en forma de grid (requisito).
- **TabBar / TabBarView**: para secciones separadas en una pantalla (requisito).
- **ExpansionPanelList**: tercer widget elegido por interacción y para demostrar estados & `setState()`.

## Ciclo de vida evidencia
Se registra en consola el output de:
- `initState()` — inicialización de variables y controladores.
- `didChangeDependencies()` — re-sincronización cuando cambian dependencias.
- `build()` — renderizado.
- `setState()` — actualización de `counter`.
- `dispose()` — liberación de controladores.

(Adjuntar capturas de la consola en el PDF.)

## Flujo GitFlow
1. Desde `dev`: `git checkout -b feature/taller_paso_parametros`
2. Trabajar y commitear.
3. Hacer PR desde `feature/taller_paso_parametros` → `dev`.
4. Tras revisión: merge a `dev`. Integrar `dev` a `main` y push.
5. Incluir la URL de dev/main en Moodle.

## Notas
- Versión de `go_router` usada: X.X.X (indicar la versión en `pubspec.lock`).
- Probar comportamientos de `go`, `push` y `replace` con el botón físico “atrás” y con el `AppBar` para evidenciar la diferencia.
