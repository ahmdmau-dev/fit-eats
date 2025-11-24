# 🥗 FitEats AI - Meal & Workout Planner

![Flutter](https://img.shields.io/badge/Flutter-3.32.4-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.8.1-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-Proprietary-red)

**FitEats AI** is a premium Flutter template for building AI-powered meal and workout planning applications. This template features clean architecture, multiple AI provider support, and flexible data storage options.

---

## ✨ Features

### 🤖 AI-Powered
- **Multiple AI Providers**: OpenAI, Gemini, Claude, or Mock
- **Smart Meal Planning**: Generate personalized meal plans based on goals, diet type, and allergies
- **Workout Generation**: Create custom workout routines based on fitness level and preferences
- **Recipe Suggestions**: AI-generated recipes with ingredients and cooking steps

### 🏗️ Architecture
- **Clean Architecture**: Separation of concerns with domain, data, and presentation layers
- **BLoC Pattern**: Predictable state management
- **Injectable DI**: Auto-generated dependency injection
- **Freezed Models**: Immutable data classes
- **Either Type**: Functional error handling with Dartz

### 💾 Flexible Storage
- **Offline-First**: Works without internet using Hive
- **Firebase Support**: Optional cloud sync with Firestore
- **Supabase Support**: Alternative backend option
- **Mode Switching**: Easy toggle between storage modes

### 🎨 Modern UI
- **Custom Components**: No heavy UI frameworks
- **Lucide Icons**: 546+ modern icons with 6 stroke weights
- **Google Fonts**: Beautiful typography
- **Smooth Animations**: flutter_animate & Lottie
- **Dark Mode**: Full theme support
- **Charts**: fl_chart for nutrition and progress tracking

---

## 📦 Tech Stack

### Core
- **State Management**: flutter_bloc ^8.1.3
- **Dependency Injection**: injectable ^2.3.2 + get_it ^7.6.4
- **Functional Programming**: dartz ^0.10.1

### Local Storage
- **Database**: hive ^2.2.3
- **Preferences**: shared_preferences ^2.2.2

### Networking & Backend
- **HTTP Client**: dio ^5.4.0
- **Firebase**: firebase_core, cloud_firestore, firebase_auth
- **Supabase**: supabase_flutter ^2.0.3

### UI & Animations
- **Icons**: lucide_icons_flutter ^1.0.0
- **Fonts**: google_fonts ^6.1.0
- **Animations**: flutter_animate ^4.5.0, lottie ^3.0.0
- **Charts**: fl_chart ^0.66.0
- **Utilities**: shimmer, cached_network_image, percent_indicator

### Code Generation
- **Models**: freezed ^2.4.5
- **JSON**: json_serializable ^6.7.1
- **DI**: injectable_generator ^2.4.1

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.32.4 or higher
- Dart SDK 3.8.1 or higher
- iOS development: Xcode 15+ (macOS only)
- Android development: Android Studio

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd FitEats
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up environment variables**
   ```bash
   cp .env.example .env
   # Edit .env and add your API keys
   ```

4. **Run code generation**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

---

## 🔧 Configuration

### AI Provider Setup

Edit `.env` file:

```env
# Choose provider: openai, gemini, claude, mock
AI_PROVIDER=mock

# Add your API keys
OPENAI_API_KEY=your_key_here
GEMINI_API_KEY=your_key_here
CLAUDE_API_KEY=your_key_here
```

### Firebase Setup (Optional)

1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Add Android and iOS apps
3. Download configuration files:
   - `google-services.json` → `android/app/`
   - `GoogleService-Info.plist` → `ios/Runner/`
4. Enable Firestore and Authentication
5. Set `FIREBASE_ENABLED=true` in `.env`

### Supabase Setup (Optional)

1. Create a Supabase project at [supabase.com](https://supabase.com)
2. Copy URL and Anon Key to `.env`:
   ```env
   SUPABASE_ENABLED=true
   SUPABASE_URL=your_project_url
   SUPABASE_ANON_KEY=your_anon_key
   ```

---

## 📱 App Icons & Splash Screen

### Generate App Icons
1. Place your icon (1024x1024) at `assets/icons/app_icon.png`
2. Run:
   ```bash
   flutter pub run flutter_launcher_icons
   ```

### Generate Splash Screen
1. Place splash logo at:
   - `assets/images/splash_logo.png` (light mode)
   - `assets/images/splash_logo_dark.png` (dark mode)
2. Run:
   ```bash
   flutter pub run flutter_native_splash:create
   ```

---

## 🏗️ Project Structure

```
lib/
├── src/
│   ├── core/              # Core utilities and config
│   │   ├── config/        # App configuration
│   │   ├── constants/     # Constants and enums
│   │   ├── errors/        # Exceptions and failures
│   │   ├── theme/         # App theme
│   │   └── utils/         # Helper utilities
│   ├── data/              # Data layer
│   │   ├── datasources/   # Local, remote, AI data sources
│   │   ├── models/        # Data models (with JSON)
│   │   └── repositories/  # Repository implementations
│   ├── domain/            # Business logic layer
│   │   ├── entities/      # Domain entities
│   │   ├── repositories/  # Repository interfaces
│   │   └── usecases/      # Business use cases
│   ├── presentation/      # UI layer
│   │   ├── blocs/         # BLoC state management
│   │   ├── pages/         # Screen widgets
│   │   └── widgets/       # Reusable widgets
│   └── di/                # Dependency injection
└── main.dart              # App entry point
```

---

## 🧪 Testing

### Run Tests
```bash
# Unit tests
flutter test

# Widget tests
flutter test test/widget_test.dart

# Integration tests
flutter test integration_test/

# With coverage
flutter test --coverage
```

---

## 📝 Code Generation

When you modify Freezed models, JSON serialization, or Injectable dependencies:

```bash
# Watch mode (auto-rebuild on changes)
flutter pub run build_runner watch --delete-conflicting-outputs

# One-time build
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 🎨 Customization Guide

### Theme Colors
Edit `lib/src/core/theme/app_colors.dart`

### Typography
Edit `lib/src/core/theme/app_text_styles.dart`

### AI Prompts
Edit AI service implementations in `lib/src/data/datasources/ai/`

### Navigation
Edit routes in `lib/src/core/config/routes.dart`

---

## 📚 Documentation

- [PRD.md](PRD.md) - Product Requirements Document
- [PLAN.md](PLAN.md) - Implementation Plan
- [API Documentation](#) - Coming soon

---

## 🐛 Troubleshooting

### Build Runner Issues
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### iOS Pod Issues
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter run
```

### Android Gradle Issues
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter run
```

---

## 📄 License

This is a proprietary template. See LICENSE for details.

---

## 👨‍💻 Developer

**Ahmad Maulana**

For support or questions, please contact [your-email@example.com]

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- BLoC library for state management
- All open-source package contributors

---

**Built with ❤️ using Flutter**
