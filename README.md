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

1. **Passport (`passport.dart`):** Custom Canvas interactive world & Europe map highlighting visited, wishlisted, and planned destinations with visual stats. <img width="386" height="858" alt="image" src="https://github.com/user-attachments/assets/e67836b3-fa45-426b-a3da-1e3296d74670" />

2. **Discover (`discover.dart`):** Filterable destination grid with custom canvas artwork generation. <img width="381" height="855" alt="image" src="https://github.com/user-attachments/assets/2e2d360f-2e06-4cd5-9d9f-60f3c75395d6" />

3. **Plan Trip (`planner.dart`):** Recommendation engine calculating budget, travel vibe, trip duration, and group style. <img width="383" height="858" alt="image" src="https://github.com/user-attachments/assets/f032144e-8c93-407f-afc2-3b0e766bf4e2" />  <img width="382" height="714" alt="image" src="https://github.com/user-attachments/assets/68b4892c-4c5f-4cb9-ac1d-00e321f3d16e" />

4. **Community (`community.dart`):** Interactive feed allowing users to publish session-based travel stories. <img width="381" height="858" alt="image" src="https://github.com/user-attachments/assets/ea68cfb4-0df4-4f81-b642-fc9a54907a6a" />
