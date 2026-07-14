# PAZHAGU

**Pazhagu** is a prototype for a next-generation, unified communication platform with end-to-end encryption — built as a single Flutter codebase targeting Android, iOS, Web, Windows, macOS, and Linux.

> ⚠️ **Status: Early prototype.** The app shell, navigation, data model, and core services (encryption, local storage) are in place, but most feature screens are currently placeholders. See [Current State](#-current-state-read-this-first) below for specifics.

---

## 📖 Table of Contents

- [What This Is](#what-this-is)
- [Feature Areas](#-feature-areas)
- [Tech Stack](#-tech-stack)
- [Architecture](#-architecture)
- [Project Structure](#-project-structure)
- [Current State (read this first)](#-current-state-read-this-first)
- [Getting Started](#-getting-started)
- [Roadmap](#-roadmap)
- [License](#-license)

---

## What This Is

Pazhagu combines messaging, social feeds, calendar, media rooms, and file storage into one app — with two ideas at its core:

1. **"Modes" — separate life contexts in one app.** Instead of one flat inbox, Pazhagu lets you switch between **Private**, **Personal**, **Work**, and custom modes you define yourself. Each mode can have its own isolated local database (chats, posts, and events are all tagged and queried by mode), so your work chats and personal chats don't mix.
2. **End-to-end encryption by default.** Messages are encrypted client-side using ChaCha20-Poly1305 (via the `cryptography` package) before they're stored or sent.

---

## 🧩 Feature Areas

Based on the screens and models currently in the codebase:

- **Chats** — 1:1 messaging with encryption flags and view-once messages
- **Moments & Stories** — ephemeral media posts (Instagram/WhatsApp-Status-style)
- **Posts / Media feed** — a scrollable content feed with likes and comments
- **Calendar** — events with reminders, scoped per mode
- **Rooms** — shared local/online audio, video, and music sessions
- **Map** — location-based screen (uses `geolocator`)
- **Contacts**
- **AI Hub** — placeholder screen for AI-assisted features
- **Security** — a "codeword" file-access screen (a hidden/duress-style access pattern)
- **Storage** — backup options, cloud storage, and local encrypted storage
- **QR device linking** — link a new device or scan a code via `qr_flutter` / `mobile_scanner`
- **Notifications & Updates**
- **Customizable UI** — three selectable visual styles (glassmorphism, liquid, neumorphism) and a choice of rectangular or circular nav bar, with reorderable/toggleable nav items

---

## 🛠 Tech Stack

| Concern | Package(s) |
|---|---|
| Framework | Flutter (Dart SDK ^3.0.0) |
| State management | `provider` |
| Local database | `sqflite` |
| Secure local storage | `flutter_secure_storage` |
| Encryption | `cryptography` (ChaCha20-Poly1305 AEAD) |
| Networking | `http`, `web_socket_channel` |
| Media | `image_picker`, `camera`, `video_player`, `file_picker` |
| Location | `geolocator` |
| QR codes | `qr_flutter`, `mobile_scanner` |
| Push / analytics (optional) | `firebase_core`, `firebase_messaging`, `firebase_analytics` |
| Fonts | Oxanium (bundled) |

---

## 🏗 Architecture

```
UI (screens/, widgets/)
      │
      ▼
State (providers/) ── ThemeProvider · ModeProvider · AuthProvider · SettingsProvider
      │
      ▼
Services (services/) ── ApiService (remote) · LocalStorageService (sqflite) ·
                          EncryptionService · SearchService · QrCodeService
      │
      ▼
Models (models/) ── User · Chat · Message · Post · Story · Moment · Event · Memory
```

`LocalStorageService` listens to both `ModeProvider` and `SettingsProvider`: when **isolated mode** is on (the default), it opens a *separate SQLite database per mode* (`pazhagu_private.db`, `pazhagu_personal.db`, `pazhagu_work.db`, etc.); when off, everything shares one `pazhagu.db`.

---

## 📁 Project Structure

```
pazhagu/
├── lib/
│   ├── main.dart              # App entry point, providers, theming
│   ├── models/                # Plain data classes (User, Chat, Message, Post, Story, Moment, Event, Memory)
│   ├── providers/              # ThemeProvider, ModeProvider, AuthProvider, SettingsProvider
│   ├── services/                # ApiService, EncryptionService, LocalStorageService, SearchService, QrCodeService
│   ├── styles/                   # glassmorphism / liquidity / neumorphism UI kits
│   ├── widgets/                   # Shared widgets (nav bar, sidebar, styled containers, post widget)
│   └── screens/                    # Feature screens (see Current State below for what's implemented)
├── android/ ios/ web/ windows/ macos/ linux/   # Flutter platform targets
├── assets/
│   ├── fonts/                       # Oxanium font family
│   ├── images/ · animations/
│   └── translations/                 # Currently empty — i18n not yet wired up
├── test/                               # See Current State — mostly unmodified template
├── pubspec.yaml
└── README.md
```

---

## 🔍 Current State (read this first)

This section exists so nobody — including future-you — mistakes the scaffold for a finished app. As of this writing:

- **Most feature screens are placeholders.** `ai_hub_screen.dart`, `contacts_screen.dart`, `map_screen.dart`, `notification_screen.dart`, the four `room/*_screen.dart` files, `codeword_file_access_screen.dart`, all three `storage/*_screen.dart` files, `updates_screen.dart`, and `chat_detail_screen.dart` are each ~17-20 lines — a `Scaffold` with a title and a single "coming soon"-style `Text` widget, no real functionality yet.
- **The more developed screens** are `home_screen.dart` (321 lines), `calendar_screen.dart` (353 lines), `moments/moments_screen.dart` (298 lines), `stories/stories_screen.dart` (219 lines), `room/room_screen.dart` (202 lines), the auth flow (`signup_screen.dart`, `login_screen.dart`, `otp_screen.dart`), and `create_post_screen.dart`.
- **There are duplicate/legacy screen files** — e.g. `lib/screens/chats_screen.dart` alongside `lib/screens/chat/chats_screen.dart`, `lib/screens/stories_screen.dart` alongside `lib/screens/stories/stories_screen.dart`, `lib/screens/media_screen.dart` alongside `lib/screens/media/media_screen.dart`, and `lib/screens/room_screen.dart` alongside `lib/screens/room/room_screen.dart`. These look like an in-progress reorganization into subfolders — worth deciding which copy is canonical and removing the other.
- **`EncryptionService` is real and functional-looking** — ChaCha20-Poly1305 via the `cryptography` package, with matching encrypt/decrypt logic. (An earlier, slightly buggy version is left commented out at the top of the file and can be deleted.)
- **`ApiService` has no real backend** — every method points at `https://your-domain.com/api/v1`, a placeholder. Auth, chats, messages, and posts endpoints are defined but will fail against any real server until a backend exists.
- **`SearchService` is a stub** — `search()` just prints to the console with two `TODO` comments; no actual search logic is implemented yet.
- **Local storage is real and working** — `LocalStorageService` creates actual SQLite tables (`messages`, `chats`, `posts`, `events`) and supports per-mode database isolation.
- **`assets/translations/` is empty** — the folder exists but no translation files have been added; there's no i18n wired into the app yet despite the folder being scaffolded.
- **The test suite is effectively untouched** — `test/widget_test.dart` is still the default Flutter counter-app smoke test (it looks for a `+` icon and a `0`/`1` counter, which don't exist in this app, so it would fail if run). The `test/models`, `test/providers`, `test/screens`, `test/services`, and `test/widgets` folders exist but are empty.
- **No license file is present** in the repository yet.

None of this is a criticism — it's exactly what you'd expect from an app scaffolded feature-first (navigation, providers, data models, and core services built out) before each screen gets its real implementation. Listed here so it's easy to track what's real vs. placeholder.

---

## 🚀 Getting Started

**Prerequisites**
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart ^3.0.0)
- A configured target (Android/iOS emulator, or desktop/web support enabled)

```bash
git clone https://github.com/AMAR-AS/pazhagu.git
cd pazhagu
flutter pub get
flutter run
```

### Build commands

```bash
# Clean & get dependencies
flutter clean
flutter pub get

# Android App Bundle (Google Play)
flutter build appbundle --release

# iOS (App Store)
flutter build ios --release

# Web
flutter build web --release

# Windows
flutter build windows --release

# macOS
flutter build macos --release

# Run in development
flutter run --release
```

> **Note:** `ApiService` currently points at a placeholder URL, so any network-backed feature (auth, remote chats/posts) needs a real backend before it will work end-to-end.

---

## 🗺️ Roadmap

Suggested near-term priorities, based on the current state of the code:

- [ ] Resolve the duplicate screen files (`chats_screen.dart`, `stories_screen.dart`, `media_screen.dart`, `room_screen.dart`) and settle on one location per screen
- [ ] Point `ApiService.BASE_URL` at a real backend, or build one
- [ ] Implement the ~13 placeholder screens (AI Hub, Contacts, Map, Notifications, Room sub-screens, Codeword security, Storage screens, Updates, Chat detail)
- [ ] Implement real search logic in `SearchService`
- [ ] Remove the dead, commented-out `EncryptionService` code block
- [ ] Add translation files to `assets/translations/` and wire up i18n
- [ ] Replace `test/widget_test.dart` with real tests for this app, and fill in the empty `test/` subfolders
- [ ] Add a license

---

## 📄 License

No license file is currently included in this repository. Add one (e.g. MIT, Apache 2.0) before accepting external contributions or publishing a release.

---

## 👤 Author

Created and maintained by [AMAR-AS](https://github.com/AMAR-AS).
