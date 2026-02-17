# Secure Email Viewer 🔐

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

A Flutter application that loads and displays locally stored email messages in Protocol Buffer format with cryptographic integrity verification using SHA-256 hashing.

## App Demo Video - Secure Email Viewer

https://github.com/user-attachments/assets/ef13ee6b-aa7c-4321-9a18-0f9c98275cab

## Features ✨

- 📧 **Protocol Buffer Email Loading** - Loads `.pb` files from local assets
- 🔒 **SHA-256 Hash Verification** - Validates integrity of email body and attachments
- 🖼️ **Image Attachments** - Displays embedded images with verification
- 🎨 **Dark/Light Mode** - Supports theme switching
- ⚡ **BLoC State Management** - Clean architecture with separation of concerns
- 💫 **Shimmer Loading** - Smooth loading animations

## Architecture 🏗️

This project follows clean architecture principles with BLoC pattern:

```
lib/
├── app/
│   ├── Business Logic/
│   │   ├── EmailViewer/          # BLoC for email viewing
│   │   └── Theme/                # Theme management
│   ├── Data Layer/
│   │   ├── Models/protos/        # Generated protobuf code
│   │   └── Repositories/         # Data access layer
│   └── UI/
│       └── Screens/EmailViewer/  # Email viewer UI
├── assets/
│   ├── sample_email.pb           # Sample protobuf email file
│   └── sample_image.png          # Sample attachment
└── protos/
    └── email.proto               # Protocol buffer schema
```

## Protocol Buffer Schema 📋

```protobuf
message EmailMessage {
  string sender_email_address = 1;
  string subject = 2;
  string body = 3;
  bytes attached_image = 4;
  string body_hash = 5;    // SHA-256 hash of body
  string image_hash = 6;   // SHA-256 hash of image
}
```

## Getting Started 🚀

### Prerequisites

- Flutter SDK ^3.35.0
- Dart SDK ^3.9.0
- Protocol Buffers Compiler (`protoc`)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/secure_email_viewer.git
   cd secure_email_viewer
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Install protobuf compiler** (if not already installed)
   ```bash
   # macOS
   brew install protobuf
   
   # Linux
   sudo apt-get install protobuf-compiler
   
   # Windows
   # Download from https://github.com/protocolbuffers/protobuf/releases
   ```

4. **Install Dart protoc plugin**
   ```bash
   dart pub global activate protoc_plugin 21.1.2
   ```

### Running the App

The project contains 3 flavors:

```bash
# Development
flutter run --flavor development --target lib/main_development.dart

# Staging
flutter run --flavor staging --target lib/main_staging.dart

# Production
flutter run --flavor production --target lib/main_production.dart
```

_*Secure Email Viewer works on iOS, Android, Web, macOS, and Windows._

## Generating Protocol Buffer Code 🔧

If you modify the `.proto` schema, regenerate the Dart code:

```bash
protoc --dart_out=lib/app/Data\ Layer/Models protos/email.proto
```

**Important:** Ensure `protoc_plugin` version 21.1.2 is used to match `protobuf` package 3.1.0:

```bash
dart pub global activate protoc_plugin 21.1.2
```

## Generating Sample Email Files 📧

### Using Dart Script (Recommended)

Run the included Dart script to generate a new `sample_email.pb` file:

```bash
dart run bin/generate_email.dart
```



## Hash Verification Process 🔍

1. **Load Email** - App loads `sample_email.pb` from assets
2. **Parse Protobuf** - Deserializes binary data into `EmailMessage`
3. **Compute Hashes** - Calculates SHA-256 for body and image
4. **Compare** - Matches computed hashes with stored hashes
5. **Display Status** - Shows ✅ (verified) or ❌ (failed) badges

### Verification States

- **✅ Green Checkmark** - Hash matches, content is verified
- **❌ Red Error Icon** - Hash mismatch, content may be tampered

## State Management 🔄

Uses **BLoC (Business Logic Component)** pattern:

```dart
// Events
LoadEmailEvent(String path)

// States
EmailInitial()
EmailLoading()
EmailLoaded(EmailMessage message, ValidationResult validation)
EmailError(String message)
```

## Testing 🧪

Run all unit and widget tests:

```bash
very_good test --coverage --test-randomize-ordering-seed random
```

View coverage report:

```bash
# Generate coverage report
genhtml coverage/lcov.info -o coverage/

# Open in browser
open coverage/index.html
```

## Project Structure 📁

```
secure_email_viewer/
├── assets/                      # Static assets
│   ├── sample_email.pb         # Sample protobuf email
│   └── sample_image.png        # Sample image attachment
├── lib/
│   ├── app/
│   │   ├── Business Logic/
│   │   │   ├── EmailViewer/
│   │   │   │   ├── email_viewer_bloc.dart
│   │   │   │   ├── email_viewer_event.dart
│   │   │   │   └── email_viewer_state.dart
│   │   │   └── Theme/
│   │   ├── Data Layer/
│   │   │   ├── Models/protos/
│   │   │   │   └── email.pb.dart        # Generated protobuf code
│   │   │   └── Repositories/
│   │   │       └── email_repository.dart
│   │   └── UI/
│   │       └── Screens/EmailViewer/
│   │           └── email_viewer_page.dart
│   ├── bootstrap.dart
│   └── main_*.dart              # Flavor entry points
├── protos/
│   └── email.proto              # Protocol buffer schema
└── pubspec.yaml
```

## Key Dependencies 📦

```yaml
dependencies:
  flutter_bloc: ^9.1.1          # State management
  protobuf: ^3.1.0              # Protocol buffers
  crypto: ^3.0.3                # SHA-256 hashing
  shimmer: ^3.0.0               # Loading animations
  equatable: ^2.0.7             # Value equality

dev_dependencies:
  protoc_plugin: 21.1.2         # Protobuf code generation
  very_good_analysis: ^10.0.0   # Linting rules
```

## Troubleshooting 🔧

### Protobuf Compilation Errors

If you see `$_clearField` method errors:

1. Ensure `protoc_plugin` version matches `protobuf` package:
   ```bash
   dart pub global activate protoc_plugin 21.1.2
   ```

2. Regenerate protobuf code:
   ```bash
   protoc --dart_out=lib/app/Data\ Layer/Models protos/email.proto
   ```
3. Use this way also to generate a sample db
  dart run bin/generate_email.dart

### Hash Verification Fails

- Ensure UTF-8 encoding: Use `utf8.encode()` not `String.codeUnits`
- Verify image bytes are unchanged
- Check hash format is lowercase hex string

## Contributing 🤝

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments 🙏

- Built with [Very Good CLI][very_good_cli_link] 🤖
- Uses [Protocol Buffers](https://developers.google.com/protocol-buffers) for data serialization
- State management with [flutter_bloc](https://pub.dev/packages/flutter_bloc)

---

[coverage_badge]: coverage_badge.svg
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
