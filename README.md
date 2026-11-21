# ROAM - Travel App Prototype

ROAM is a Flutter application designed for interactive travel tracking, trip planning based on budget and travel preferences, destination discovery, and community sharing.

This repository contains the Flutter project, including its Dart source code and web configuration.

**Important:** The repository already contains the Flutter project structure. You do not need to generate a new project or move any Dart files. Follow the instructions below to install Flutter, install dependencies, and run the application.

---

## 1. Prerequisites

Before running the application, make sure you have:

- [Visual Studio Code](https://code.visualstudio.com/)
- [Git](https://git-scm.com/downloads)
- [Google Chrome](https://www.google.com/chrome/)
- Flutter SDK (installation instructions below)

**Recommended platform: Web (Google Chrome).**

Using Chrome is the easiest way to test the application without installing Android Studio, Android emulators, or additional mobile development tools.

### Flutter and Dart

Flutter includes the Dart SDK, so **you do not need to install Dart separately**.

The recommended installation method is through Visual Studio Code.

---

## 2. Install Flutter and Dart

### Step 1 — Install VS Code

Download and install Visual Studio Code:

https://code.visualstudio.com/

### Step 2 — Install the Flutter extension

1. Open VS Code.
2. Navigate to the **Extensions** tab (`Ctrl + Shift + X` on Windows/Linux or `Cmd + Shift + X` on macOS).
3. Search for **Flutter**.
4. Install the official Flutter extension.

The Dart extension will be installed automatically.

### Step 3 — Download the Flutter SDK

1. Open the VS Code Command Palette:
   - Windows/Linux: `Ctrl + Shift + P`
   - macOS: `Cmd + Shift + P`
2. Search for `Flutter: New Project`.
3. If Flutter is not installed, select **Download SDK**.
4. Choose a folder where Flutter should be installed.
5. Select **Clone Flutter**.
6. When installation finishes, select **Add SDK to PATH**.
7. Restart VS Code and your terminal.

For additional help, follow the official installation guide:

https://docs.flutter.dev/install/with-vs-code

### Step 4 — Verify installation

Open a new terminal and execute:

```bash
flutter --version
```

```bash
dart --version
```

Both commands should display installed version information.

Next, run:

```bash
flutter doctor
```

This checks whether your development environment is correctly configured.

**Note:** Warnings related to Android Studio, Xcode, or desktop development tools can be ignored if you only intend to run the application in Chrome.

Make sure Flutter and Chrome are correctly detected.

---

## 3. Clone the Repository

Open a terminal and execute:

```bash
git clone https://github.com/nikwilldoit/Analitiki_Diadiktiou_Team91.git
```

Navigate to the repository:

```bash
cd Analitiki_Diadiktiou_Team91
```

Alternatively, download the repository as a ZIP file from GitHub, extract it, and open the extracted folder in VS Code.

**Note:** This repository is private, so GitHub access is required.

---

## 4. Project Structure

The repository already contains the Flutter project structure:

```text
Analitiki_Diadiktiou_Team91/
├── lib/
│   ├── main.dart
│   ├── core.dart
│   ├── components.dart
│   ├── passport.dart
│   ├── discover.dart
│   ├── planner.dart
│   └── community.dart
├── test/
├── web/
├── .gitignore
├── .metadata
├── README.md
├── analysis_options.yaml
├── pubspec.lock
└── pubspec.yaml
```

All application Dart files are already inside `lib/`, and `lib/main.dart` is the application entry point.

**Do not run `flutter create`, move files, or replace `lib/main.dart`.** Continue directly to installing the dependencies in the next section.

---

## 5. Install Project Dependencies

From the project root directory, execute:

```bash
flutter pub get
```

This downloads the dependencies specified in `pubspec.yaml`.

The application is designed primarily around Flutter's built-in Material libraries.

If the source code requires additional third-party packages, those packages must also be added to `pubspec.yaml` before running the application.

---

## 6. Run the Application

### Recommended — Run in Google Chrome

Make sure Chrome is installed.

Execute:

```bash
flutter run -d chrome
```

Flutter will compile and launch the application in Chrome.

The first launch may take longer because Flutter needs to generate and compile the required files.

### Alternative — Run from VS Code

1. Open the cloned repository folder in VS Code.
2. Open `lib/main.dart`.
3. Select **Chrome** as the target device.
4. Press `F5` or select **Run > Start Debugging**.

### Optional — Run on Android or Desktop

If you want to run the application on Android, Windows, macOS, or Linux, additional platform-specific development tools may be required.

Follow the relevant platform setup instructions:

https://docs.flutter.dev/platform-integration

You can generate additional platform directories using Flutter's project creation tools.

For initial evaluation, **Chrome is strongly recommended**.

---

## 7. Troubleshooting

### Problem: `flutter` command not found

Flutter was not added to your system's PATH.

**Solution:**

- Restart VS Code and your terminal.
- Make sure the Flutter SDK installation completed successfully.
- Follow: https://docs.flutter.dev/install/add-to-path

### Problem: `No pubspec.yaml file found`

You are running the command outside the Flutter project root.

**Solution:**

Navigate to the cloned `Analitiki_Diadiktiou_Team91` folder containing `pubspec.yaml` and run:

```bash
flutter pub get
```

### Problem: Flutter displays its default counter application

Make sure you opened the correct repository folder and are running its `lib/main.dart` entry point, not a separate Flutter project.

---

### Problem: `Target of URI doesn't exist`

One or more required Dart files may be missing, located in the wrong directory, or referenced incorrectly.

**Solution:**

Verify that all seven original Dart files are inside `lib/`.

Also check whether any imported third-party packages need to be declared in `pubspec.yaml`.

### Problem: Chrome is not detected

Run:

```bash
flutter devices
```

Ensure Chrome is installed and correctly detected.

For help, visit:

https://docs.flutter.dev/platform-integration/web/setup

### Problem: Dependencies or build errors

Try:

```bash
flutter clean
flutter pub get
flutter run -d chrome
```

If an error persists, read the terminal output to identify missing packages, invalid imports, or other source-level issues.

---

## 8. Application Features

### 🛂 Passport (`passport.dart`)

Interactive world and Europe maps displaying visited, wishlisted, and planned destinations, along with travel statistics.

### 🔎 Discover (`discover.dart`)

Destination exploration with filtering options and custom visual artwork.

### 🧳 Plan Trip (`planner.dart`)

Travel recommendation system based on:

- Available budget
- Travel preferences and vibe
- Trip duration
- Group or travel style

### 👥 Community (`community.dart`)

Interactive feed where users can publish and explore travel stories during their application session.

### Supporting Files

- `main.dart` — application entry point
- `core.dart` — core application logic
- `components.dart` — reusable interface components

---

## 9. Quick Setup Summary

For developers who already have Flutter and Git installed:

```bash
# Clone the repository
git clone https://github.com/nikwilldoit/Analitiki_Diadiktiou_Team91.git

# Enter the repository
cd Analitiki_Diadiktiou_Team91

# Install dependencies
flutter pub get

# Run in Chrome
flutter run -d chrome
```

No project generation or file relocation is required. The ROAM application should now launch in Chrome, provided all required dependencies are available and the source code compiles successfully.

---

## 10. Additional Resources

- [Flutter Official Documentation](https://docs.flutter.dev/)
- [Flutter Installation Guide](https://docs.flutter.dev/install)
- [Dart Documentation](https://dart.dev/guides)
- [Flutter Web Setup](https://docs.flutter.dev/platform-integration/web/setup)
- [VS Code Flutter Extension](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)

---

**ROAM — Travel App Prototype**

Developed as part of the Analitiki Diadiktiou Team 91 project.
