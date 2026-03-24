# Compairifuel

Frontend application for the Compairifuel platform.

This repository contains the user interface layer of the Compairifuel ecosystem, responsible for presenting fuel comparison insights, interacting with backend services, and delivering a responsive and consistent cross-platform user experience.

## Overview

The frontend is implemented as a Flutter application, enabling a single codebase for multiple platforms (web, mobile, and potentially desktop).

It is designed to:
- Provide a clear and intuitive comparison of fuel-related data
- Deliver a performant and responsive user interface
- Ensure consistency across platforms
- Remain maintainable and scalable as the platform evolves

## Why Flutter & Dart?

Flutter was chosen to enable a consistent, high-performance frontend across multiple platforms from a single codebase.

Flutter was selected over alternatives such as React and native development due to its ability to balance development speed, performance, and cross-platform consistency, despite the initial learning curve.

### Advantages

- **Cross-platform development**: A single codebase supports web and mobile, reducing duplication and maintenance overhead  
- **Strong UI control**: Flutter’s rendering engine allows precise and consistent UI implementation across platforms  
- **Performance**: Compiled Dart code and the Flutter engine provide near-native performance  
- **Developer experience**: Features like hot reload significantly improve development speed and iteration  
- **Consistency**: UI behavior and appearance are not dependent on platform-specific components  

### Trade-offs

- **Learning curve**: Flutter introduces its own rendering model and architectural patterns, which require time to learn  
- **Ecosystem maturity**: Compared to more established web frameworks, some libraries and integrations may be less mature  
- **Bundle size (especially web)**: Flutter web applications can have larger initial load sizes compared to traditional web apps  
- **Non-native rendering**: Flutter does not use native UI components, which may lead to differences in platform-specific look and feel.

## Tech Stack

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: Riverpod
- **Styling**: Flutter theming system
- **Version Management**: FVM (Flutter Version Management)
- **Package Manager**: Pub

## Project Structure

```bash
lib/
├── src/
│   ├── global/
│   │   ├── providers/        # Riverpod providers (global state management)
│   │       └── services/     # API clients and external integrations
│   │   ├── theme/            # Application theming (colors, typography, etc.)
│   │   ├── ui/
│   │   │   ├── screens/      # Top-level screens/pages
│   │   │   └── widgets/      # Reusable UI components
│   │   ├── model/            # Data models and domain entities
│   │   ├── utils/
│   │   │   ├── extension/    # Dart extensions
│   │   │   └── typedef.dart  # Shared type definitions
│   ├── app.dart              # Root app configuration (MaterialApp, providers, etc.)
│   └── routes.dart           # Application routing configuration
├── localization/             # Localization / i18n resources
└── main.dart                 # Application entry point

assets/                       # Static assets (images, fonts, etc.)
test/                         # Unit and widget tests
```
> As the application grows, the structure may evolve toward a feature-based architecture to improve modularity and scalability.

### Structure Notes

The project uses a custom src/ layer inside lib/, which is not standard in Flutter but helps organize application code more explicitly.
The global/ directory contains shared logic and cross-cutting concerns used throughout the app.

UI is separated into screens (pages) and widgets (reusable components).
State management is centralized using Riverpod providers.
Utility logic (extensions, typedefs) is isolated to keep business logic clean.

## Setup

### Flutter and FVM

This project uses FVM (Flutter Version Management) to manage Flutter SDK versions.
To install FVM, follow the instructions on the [FVM Installation Guide](https://fvm.app/documentation/getting-started/installation).
After installing FVM, run the following command in the project directory to install the correct Flutter SDK version:

```bash
fvm install
```

This will install the Flutter SDK and Dart within the project. The version that gets installed is determined by the flutter version specified in the `.fvmrc` file. The Flutter and Dart CLI can then be used using their FVM proxies:

```bash
fvm flutter
fvm dart
```

For more information on using Flutter and FVM with this project, refer to the [Compairifuel Flutter Version Management Guide](./docs/Flutter.md).

## Development

Run the application locally:
```bash
fvm flutter run
# or
fvm flutter run -d chrome
```

The app will typically run on (web):
```
http://localhost:{{port}}
```
> A port will be randomly assigned or configured in `web_dev_config.yaml`.

### Useful Commands
```bash
fvm flutter pub get        # Install dependencies
fvm flutter run            # Run app
fvm flutter build web      # Build for web
fvm flutter build apk      # Build Android APK
fvm flutter test           # Run tests
fvm flutter analyze        # Static analysis
dart format .              # Automatic Default Dart Formatting
```

### Environment Variables
Environment configuration is handled via `.env` files.

A `.env.template` is provided and kept up-to-date.

### API Integration

The frontend communicates with backend services via REST/HTTP APIs.
- Base URL configured via environment variables
- API logic is organized within the `providers/services` layer

## Related Repositories
- Backend: https://github.com/Compairifuel/CompairifuelAPI
- Organisation / CI: https://github.com/Compairifuel/.github

## Notes

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
