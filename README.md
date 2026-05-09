# Petzy

> Caring for paws, claws, and tails.

Cross-platform Flutter app for pet owners — care, hotel, school, marketplace, community, reels & bookings.

| | |
|---|---|
| Version | `1.0.0+1` |
| Flutter | `^3.10.7` |
| State / DI / Routing | GetX |
| HTTP | Dio (via `NetworkCaller`) |
| Storage | SharedPreferences (via `StorageService`) |
| Platforms | Android, iOS |

---

## Quick start

```bash
flutter pub get
flutter run
```

- Entry point → [lib/main.dart](lib/main.dart)
- Initial route → `SplashScreen` → `BottomNavScreen`
- Routes table → [lib/routes/app_routes.dart](lib/routes/app_routes.dart)

## Project structure (do not break)

```
lib/
├── main.dart                  # Boot: init ThemeController, run MyApp
├── app.dart                   # GetMaterialApp + Sizer shell
├── core/                      # Shared, cross-feature code
│   ├── bindings/              # Initial DI bindings
│   ├── common/                # Shared widgets & text styles
│   ├── controllers/           # App-wide controllers (theme)
│   ├── models/                # Shared models (ResponseData)
│   ├── services/              # NetworkCaller, StorageService, Firebase (off)
│   └── utils/                 # constants, theme, helpers, validators, logging
├── features/                  # One folder per feature (see rules below)
└── routes/app_routes.dart     # Named routes
```

## Rules for every developer

Read this before writing any code.

1. **Feature-first.** New screens/logic go under `lib/features/<name>/` with this layout:
   ```
   features/<name>/
   ├── controllers/   # GetxController — state + logic (no BuildContext)
   ├── models/        # Plain Dart models (fromJson/toJson)
   ├── services/      # API calls via NetworkCaller
   ├── presentation/  # screens/ and widgets/
   └── bindings/      # GetX Bindings (optional)
   ```
2. **Never import across features.** Cross-feature sharing goes through `core/`.
3. **GetX only.** No BLoC / Provider / Riverpod. Use `.obs` + `Obx`.
4. **UI is thin.** Widgets render state, controllers do the work.
5. **Navigate by name.** `Get.toNamed(AppRoute.xxx)` — never `MaterialPageRoute`. Register every new route in [lib/routes/app_routes.dart](lib/routes/app_routes.dart).
6. **One HTTP door.** All network calls go through [NetworkCaller](lib/core/services/network/network_caller.dart). Do not `new Dio()` inside a feature.
7. **One storage door.** All `SharedPreferences` access goes through [StorageService](lib/core/services/cache/storage_service.dart).
8. **Use design tokens.** Colours → [AppColors](lib/core/utils/constants/colors.dart). Text → [AppTextStyle](lib/core/common/styles/global_text_style.dart). Icons/images → [AppIcons](lib/core/utils/constants/icon_path.dart) / [AppImages](lib/core/utils/constants/image_path.dart). **No hard-coded hex, font sizes, or asset strings.**
9. **Use the sizer.** Sizes with `.w` / `.h` / `.sp` / `.r` — not raw pixels.
10. **No `print`.** Use `AppLoggerHelper.debug/info/warning/error`.
11. **Keep the analyzer clean.** `flutter analyze` must pass on every PR.
12. **Strings.** Put user-facing copy in [app_texts.dart](lib/core/utils/constants/app_texts.dart) (i18n-ready).
13. **Secrets.** Never commit API keys — use `--dart-define` + `String.fromEnvironment`.

## How to add things (cheat sheet)

| Task | Steps |
|---|---|
| New screen | Create under `features/<name>/presentation/screens/`, add a controller + binding, register a `GetPage` in [app_routes.dart](lib/routes/app_routes.dart) |
| New API call | Add a method to the feature's `services/` class using `NetworkCaller`, map the response into a model, call it from the controller |
| New colour / font size | Add it to [AppColors](lib/core/utils/constants/colors.dart) / [AppTextStyle](lib/core/common/styles/global_text_style.dart) — don't inline it |
| New asset | Drop into [assets/](assets/), register in [icon_path.dart](lib/core/utils/constants/icon_path.dart) or [image_path.dart](lib/core/utils/constants/image_path.dart), declare in [pubspec.yaml](pubspec.yaml) |
| New persisted value | Add a typed getter/setter in [StorageService](lib/core/services/cache/storage_service.dart) |
| New theme toggle | Use [ThemeController](lib/core/controllers/theme_controller.dart) — don't touch SharedPreferences directly |

## Useful commands

```bash
flutter pub get           # install deps
flutter analyze           # lint (must be clean)
flutter test              # tests
flutter run               # run on attached device
flutter build apk         # Android APK
flutter build appbundle   # Android AAB
flutter build ipa         # iOS release
```

## Branch & PR

- Branches: `feat/<scope>`, `fix/<scope>`, `chore/<scope>`, `docs/<scope>`
- Run `flutter analyze && flutter test` before pushing
- PR must include: summary, screenshots (for UI), test plan

## Disabled subsystems (do not enable silently)

Firebase/FCM, WebSocket and i18n scaffolding exist but are commented out. Enabling them requires adding packages, editing `main.dart`, and updating [ARCHITECTURE.md](ARCHITECTURE.md) in the same PR.

## Further reading

- [ARCHITECTURE.md](ARCHITECTURE.md) — full architecture deep-dive, conventions, extension recipes
- Flutter docs → <https://docs.flutter.dev>
- GetX docs → <https://pub.dev/packages/get>
# flutter_tamplate_getx
# massimotrava21
