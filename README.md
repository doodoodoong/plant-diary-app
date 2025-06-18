# Plant Diary App

A Flutter application for managing plant care with webview integration.

## Features

- 📱 Responsive design for both mobile and tablet devices
- 🌐 WebView integration for web-based plant diary functionality
- 🔄 Network connectivity monitoring
- 💫 Smooth splash screen with loading animation
- 🎨 Custom Material Design theme
- 📋 Error handling and loading states

## Project Structure

```
lib/
├── app.dart                 # Main app configuration
├── main.dart               # App entry point
├── constants/
│   └── app_constants.dart  # App-wide constants
├── screens/
│   ├── splash_screen.dart
│   ├── webview_screen.dart
│   └── tablet_webview_screen.dart
├── services/
│   ├── connectivity_service.dart
│   ├── device_service.dart
│   └── webview_service.dart
├── utils/
│   ├── app_theme.dart
│   └── responsive_utils.dart
└── widgets/
    ├── custom_app_bar.dart
    ├── error_widget.dart
    ├── loading_widget.dart
    ├── responsive_layout.dart
    └── tablet_app_bar.dart
```

## Dependencies

- **webview_flutter**: ^4.13.0 - WebView implementation
- **connectivity_plus**: ^6.1.4 - Network connectivity monitoring
- **cupertino_icons**: ^1.0.8 - iOS style icons

## Getting Started

### Prerequisites

- Flutter SDK (>=3.8.1)
- Android Studio / Xcode for platform-specific builds

### Installation

1. Clone the repository:
```bash
git clone https://github.com/doodoodoong/plant-diary-app.git
cd plant-diary-app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Platform Support

- ✅ Android
- ✅ iOS
- ✅ macOS
- ✅ Windows

## Development

### Building for Release

#### Android
```bash
flutter build apk --release
```

#### iOS
```bash
flutter build ios --release
```

## License

This project is private and not published to pub.dev.
