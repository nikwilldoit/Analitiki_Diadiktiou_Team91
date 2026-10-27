# ROAM Travel App Prototype

ROAM is a Flutter application designed for interactive travel tracking, trip planning based on budget/vibe, destination discovery, and community sharing.

---

## Project Structure

Ensure all source files are located inside the `lib/` directory as shown below:

```text
roam_app/
└── lib/
    ├── main.dart
    ├── core.dart
    ├── components.dart
    ├── passport.dart
    ├── discover.dart
    ├── planner.dart
    └── community.dart
```

---

## Requirements

- **Flutter SDK**: `^3.0.0` or higher
- **Dart SDK**: `^3.0.0` or higher
- Any supported platform target: **Web (Chrome)**, **macOS**, **Windows**, **Linux**, **Android Emulator**, or **iOS Simulator**.

---

## How to Run

### 1. Extract / Navigate to Project
Open your terminal inside the project root directory:
```bash
cd roam_app
```

### 2. Fetch Dependencies
Install the required packages (uses standard Flutter Material libraries):
```bash
flutter pub get
```

### 3. Launch the Application

- **Run in Web (Recommended for quick evaluation):**
  ```bash
  flutter run -d chrome
  ```

- **Run in Desktop (macOS / Windows / Linux):**
  ```bash
  flutter run -d macos    # Or: flutter run -d windows / linux
  ```

- **Run on Mobile Emulator/Device:**
  ```bash
  flutter run
  ```

---

## Features Overview

1. **Passport (`passport.dart`):** Custom Canvas interactive world & Europe map highlighting visited, wishlisted, and planned destinations with visual stats.
2. **Discover (`discover.dart`):** Filterable destination grid with custom canvas artwork generation.
3. **Plan Trip (`planner.dart`):** Recommendation engine calculating budget, travel vibe, trip duration, and group style.
4. **Community (`community.dart`):** Interactive feed allowing users to publish session-based travel stories.
