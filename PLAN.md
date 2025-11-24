# 📋 FitEats AI - Implementation Plan
**Version:** 1.1
**Project:** FitEats AI - Meal & Workout Planner
**Last Updated:** 2025-11-24

---

## 🎯 Key Technology Decisions

### Why Injectable?
- **Auto-generated DI** - Less boilerplate, more maintainable
- **Compile-time safety** - Catches injection errors early
- **Better for large projects** - This app has 10+ screens and 15+ BLoCs
- **Works seamlessly with GetIt** - Best of both worlds

### Why Custom UI (Not shadcn_ui)?
- **Lightweight** - Only include what you need (~15 packages vs 30+)
- **Fitness-optimized** - Charts, progress indicators, timers built-in
- **Easier to customize** - Template buyers can modify easily
- **Better animations** - Health apps need engaging, smooth transitions
- **No missing components** - We control what we build
- **Lucide Icons** - 546+ modern icons with 6 stroke weights for visual hierarchy

### Package Philosophy
- ✅ **Proven packages** with good maintenance
- ✅ **Minimal dependencies** for faster builds
- ✅ **Flexibility first** for template buyers
- ✅ **Premium feel** with smooth animations

---

## Table of Contents
1. [Project Setup](#phase-1-project-setup)
2. [Core Architecture](#phase-2-core-architecture)
3. [Data Layer](#phase-3-data-layer)
4. [AI Integration](#phase-4-ai-integration)
5. [Onboarding Flow](#phase-5-onboarding-flow)
6. [Home Dashboard](#phase-6-home-dashboard)
7. [Meal Planning Features](#phase-7-meal-planning-features)
8. [Workout Planning Features](#phase-8-workout-planning-features)
9. [Additional Features](#phase-9-additional-features)
10. [Polish & Testing](#phase-10-polish--testing)

---

# Phase 1: Project Setup
**Duration:** 1-2 days
**Goal:** Initialize Flutter project with proper structure and dependencies

## Step 1.1: Project Initialization
- Create new Flutter project with proper naming
- Configure `pubspec.yaml` with initial dependencies:

### Core State Management & Architecture
  - `flutter_bloc: ^8.1.3` - State management
  - `equatable: ^2.0.5` - Value equality
  - `get_it: ^7.6.4` - Service locator
  - `injectable: ^2.3.2` - Code generation for dependency injection
  - `dartz: ^0.10.1` - Functional programming (Either type for error handling)

### Local Storage
  - `hive: ^2.2.3` - NoSQL local database
  - `hive_flutter: ^1.1.0` - Hive Flutter integration
  - `shared_preferences: ^2.2.2` - Simple key-value storage

### Code Generation
  - `freezed: ^2.4.5` - Immutable classes & unions
  - `freezed_annotation: ^2.4.1` - Freezed annotations
  - `json_serializable: ^6.7.1` - JSON serialization
  - `json_annotation: ^4.8.1` - JSON annotations
  - `build_runner: ^2.4.6` - Code generation runner
  - `injectable_generator: ^2.4.1` - Injectable code generator

### Networking
  - `dio: ^5.4.0` - HTTP client
  - `pretty_dio_logger: ^1.3.1` - Network logging
  - `connectivity_plus: ^5.0.2` - Network connectivity status

### Backend (Optional Modes)
  - `firebase_core: ^2.24.2` - Firebase core
  - `cloud_firestore: ^4.14.0` - Firestore database
  - `firebase_auth: ^4.16.0` - Firebase authentication
  - `supabase_flutter: ^2.0.3` - Supabase client

### UI Components
  - `google_fonts: ^6.1.0` - Custom typography
  - `lucide_icons_flutter: ^1.0.0` - Modern icon set with 546+ icons & 6 stroke weights
  - `flutter_svg: ^2.0.9` - SVG support
  - `cached_network_image: ^3.3.1` - Image caching
  - `shimmer: ^3.0.0` - Skeleton loaders
  - `flutter_animate: ^4.5.0` - Smooth animations
  - `lottie: ^3.0.0` - Lottie animations

### Charts & Progress Indicators
  - `fl_chart: ^0.66.0` - Charts for nutrition/progress
  - `percent_indicator: ^4.2.3` - Circular/linear progress
  - `smooth_page_indicator: ^1.1.0` - Page indicators

### Utilities
  - `flutter_dotenv: ^5.1.0` - Environment variables
  - `intl: ^0.19.0` - Internationalization & date formatting
  - `path_provider: ^2.1.1` - File system paths
  - `url_launcher: ^6.2.2` - Launch URLs
  - `package_info_plus: ^5.0.1` - App version info
  - `flutter_native_splash: ^2.3.8` - Native splash screen
  - `flutter_launcher_icons: ^0.13.1` - App icons generator

### Dev Dependencies
  - `flutter_test: sdk: flutter`
  - `flutter_lints: ^3.0.1` - Linting rules
  - `mockito: ^5.4.4` - Mocking for tests
  - `bloc_test: ^9.1.5` - BLoC testing utilities

- Set up code generation tools
- Configure analysis_options.yaml with strict linting rules

## Step 1.2: Project Structure
Create the following folder structure:
```
lib/
├── src/
│   ├── core/
│   │   ├── config/
│   │   ├── constants/
│   │   ├── errors/
│   │   ├── theme/
│   │   └── utils/
│   ├── data/
│   │   ├── datasources/
│   │   │   ├── local/
│   │   │   ├── remote/
│   │   │   └── ai/
│   │   ├── models/
│   │   └── repositories/
│   ├── domain/
│   │   ├── entities/
│   │   ├── repositories/
│   │   └── usecases/
│   ├── presentation/
│   │   ├── blocs/
│   │   ├── pages/
│   │   └── widgets/
│   └── di/
│       └── injection.dart
└── main.dart
```

## Step 1.3: Development Environment
- Set up environment variables (.env file)
- Configure Firebase (create Firebase project, download config files)
- Set up build flavors (dev, staging, production)
- Configure app icons and splash screen
- Set up Git repository and .gitignore

---

# Phase 2: Core Architecture
**Duration:** 2-3 days
**Goal:** Establish clean architecture foundation

## Step 2.1: Core Configuration
- Create app config class for environment-based settings
- Set up theme system (light/dark mode)
- Create color palette and typography
- Build custom theme data
- Implement theme switching mechanism

## Step 2.2: Error Handling
- Define custom exceptions:
  - `ServerException`
  - `CacheException`
  - `AIException`
  - `NetworkException`
- Create failure classes using freezed:
  - `ServerFailure`
  - `CacheFailure`
  - `AIFailure`
  - `NetworkFailure`
- Implement error-to-failure mapper

## Step 2.3: Dependency Injection (Injectable + GetIt)
- Set up GetIt service locator with Injectable
- Create `injection.dart` with `@InjectableInit` annotation
- Configure modules for third-party dependencies:
  - Dio client module
  - Hive module
  - Firebase module (conditional)
  - Supabase module (conditional)
- Annotate classes with Injectable decorators:
  - `@singleton` - Data sources, repositories
  - `@lazySingleton` - Services
  - `@injectable` - Use cases
  - `@factory` - BLoCs
- Run code generation: `flutter pub run build_runner build`
- Create initialization function: `configureDependencies()`
- Call in main.dart before runApp()

## Step 2.4: Navigation & Routing
- Set up named routes
- Create route generator
- Implement navigation service
- Add route transitions

---

# Phase 3: Data Layer
**Duration:** 3-4 days
**Goal:** Implement data models, local storage, and repository pattern

## Step 3.1: Define Domain Entities
Create freezed classes for:
- `UserPreference` - User profile and preferences
- `MealPlan` - Daily meal plan structure
- `Recipe` - Individual recipe details
- `Nutrition` - Nutritional information
- `WorkoutPlan` - Workout plan structure
- `WorkoutExercise` - Exercise details
- `ShoppingListItem` - Shopping list items

## Step 3.2: Data Models
- Create data models (extends entities) with JSON serialization
- Add `fromJson` and `toJson` methods
- Implement model converters (model ↔ entity)
- Generate code using build_runner

## Step 3.3: Local Data Source (Hive)
- Initialize Hive
- Create Hive adapters for models
- Implement local data source interface:
  - `saveUserPreference()`
  - `getUserPreference()`
  - `saveMealPlan()`
  - `getMealPlans()`
  - `saveWorkoutPlan()`
  - `getWorkoutPlans()`
  - `saveShoppingList()`
  - `getShoppingList()`
- Implement caching logic

## Step 3.4: Remote Data Source (Firebase - Optional)
- Set up Firestore collections structure
- Implement Firebase data source interface:
  - User preferences CRUD
  - Meal plans CRUD
  - Workout plans CRUD
  - Sync mechanism
- Add offline persistence support

## Step 3.5: Remote Data Source (Supabase - Optional)
- Set up Supabase client
- Create table schemas
- Implement Supabase data source interface
- Add real-time subscription support (optional)

## Step 3.6: Repository Implementation
- Create repository interfaces in domain layer
- Implement concrete repositories in data layer:
  - `UserRepository`
  - `MealPlanRepository`
  - `WorkoutPlanRepository`
  - `ShoppingListRepository`
- Add data mode switching logic (offline/Firebase/Supabase)
- Implement error handling with Either type

---

# Phase 4: AI Integration
**Duration:** 3-4 days
**Goal:** Build AI adapter system with multiple providers

## Step 4.1: AI Service Interface
- Define `AIMealService` abstract class:
  - `generateMealPlan(MealPlanRequest)`
  - `generateRecipe(RecipeRequest)`
  - `replaceMeal(ReplaceMealRequest)`
- Define `AIWorkoutService` abstract class:
  - `generateWorkoutPlan(WorkoutPlanRequest)`
  - `generateExercises(ExerciseRequest)`

## Step 4.2: AI Request/Response Models
Create request/response models:
- `MealPlanRequest` (goal, diet type, allergies, calories)
- `MealPlanResponse`
- `RecipeRequest` (meal type, dietary restrictions)
- `RecipeResponse`
- `WorkoutPlanRequest` (level, type, focus)
- `WorkoutPlanResponse`

## Step 4.3: OpenAI Implementation
- Set up OpenAI API client
- Implement prompt engineering for meal plans
- Implement prompt engineering for workout plans
- Parse JSON responses
- Handle rate limiting and errors
- Add retry mechanism

## Step 4.4: Gemini Implementation
- Set up Gemini API client
- Adapt prompts for Gemini format
- Implement response parsing
- Handle API-specific errors

## Step 4.5: Claude Implementation
- Set up Claude API client
- Adapt prompts for Claude format
- Implement response parsing
- Handle API-specific errors

## Step 4.6: Mock AI Service
- Create mock data generators
- Implement delay simulation
- Add realistic sample responses for testing

## Step 4.7: AI Provider Adapter
- Create AI provider enum (OpenAI, Gemini, Claude, Mock)
- Implement factory pattern for provider selection
- Add API key validation
- Create settings for AI provider configuration

---

# Phase 5: Onboarding Flow
**Duration:** 3-4 days
**Goal:** Build user onboarding and personalization screens

## Step 5.1: Splash Screen
- Design animated splash screen
- Add app logo with fade-in animation
- Implement initialization logic
- Check first-time user status
- Navigate to appropriate screen

## Step 5.2: Onboarding Welcome
- Create welcome screen with app introduction
- Add swipeable carousel for features
- Include "Get Started" button
- Design visually appealing illustrations

## Step 5.3: Health Goal Selection
- Create goal selection screen (Lose weight, Gain muscle, Maintain health)
- Design card-based selection UI
- Add visual icons for each goal
- Implement single selection logic
- Add validation

## Step 5.4: Diet Type Selection
- Create diet type screen (Normal, Vegan, Keto, Low-carb, Mediterranean)
- Use card or chip-based UI
- Add descriptions for each diet type
- Implement single selection
- Add "Learn More" info dialogs

## Step 5.5: Allergy Selection
- Create allergy selection screen
- Support multi-select (Seafood, Nuts, Gluten, Lactose, etc.)
- Use checkbox or chip-based UI
- Add "None" option
- Implement search/filter for allergies

## Step 5.6: Workout Level Selection
- Create workout level screen (Beginner, Intermediate, Advanced)
- Add detailed descriptions for each level
- Use visual indicators (stars, badges)
- Implement single selection

## Step 5.7: Workout Type Selection
- Create workout type screen (Home, Gym, Mixed)
- Add equipment indicators
- Use card-based selection
- Implement single selection

## Step 5.8: Onboarding BLoC
- Create `OnboardingBloc` with states:
  - `OnboardingInitial`
  - `OnboardingInProgress`
  - `OnboardingCompleted`
  - `OnboardingError`
- Implement events:
  - `SetHealthGoal`
  - `SetDietType`
  - `SetAllergies`
  - `SetWorkoutLevel`
  - `SetWorkoutType`
  - `CompleteOnboarding`
- Save preferences to repository
- Handle navigation after completion

---

# Phase 6: Home Dashboard
**Duration:** 4-5 days
**Goal:** Build main dashboard with quick actions

## Step 6.1: Dashboard Layout
- Design responsive dashboard layout
- Create header with greeting and profile avatar
- Add calorie goal progress widget
- Design card-based layout for sections

## Step 6.2: Daily Calorie Widget
- Create circular progress indicator
- Display calories consumed vs target
- Add visual feedback with colors
- Animate progress changes

## Step 6.3: Meal Summary Widget
- Display today's meal plan summary
- Show meal cards (Breakfast, Lunch, Dinner, Snack)
- Add meal images or placeholders
- Implement tap to view detail
- Show "Not planned" state

## Step 6.4: Workout Summary Widget
- Display today's workout routine
- Show exercise count and duration
- Add progress indicator
- Include "Start Workout" button
- Show "Rest day" state

## Step 6.5: Quick Actions
- Create floating action buttons or bottom sheet:
  - "Generate Meal Plan"
  - "Generate Workout Plan"
  - "Regenerate Today"
  - "Suggest Alternatives"
- Implement action handlers
- Add loading states

## Step 6.6: Dashboard BLoC
- Create `DashboardBloc` with states:
  - `DashboardLoading`
  - `DashboardLoaded`
  - `DashboardError`
- Implement events:
  - `LoadDashboard`
  - `RefreshDashboard`
  - `GenerateMealPlan`
  - `GenerateWorkoutPlan`
- Fetch data from repositories
- Handle real-time updates

---

# Phase 7: Meal Planning Features
**Duration:** 5-6 days
**Goal:** Implement meal planning, recipes, and shopping list

## Step 7.1: Meal Plan Generator Screen
- Create meal plan request form
- Add optional calorie target input
- Include date range selector
- Show AI provider indicator
- Add "Generate" button with loading state
- Display generation progress

## Step 7.2: Meal Plan BLoC
- Create `MealPlanBloc` with states:
  - `MealPlanInitial`
  - `MealPlanGenerating`
  - `MealPlanGenerated`
  - `MealPlanError`
- Implement events:
  - `GenerateMealPlan`
  - `SaveMealPlan`
  - `LoadMealPlan`
  - `RegenerateMeal`
  - `ReplaceMeal`
- Call AI service use cases
- Handle errors and retries

## Step 7.3: Meal Plan View (Daily)
- Display meals for selected day
- Create meal cards with:
  - Image
  - Title
  - Calories
  - Meal time
- Add swipe actions (replace, delete)
- Implement tap to view recipe detail

## Step 7.4: Meal Plan View (Weekly)
- Create weekly calendar view
- Show summary for each day
- Add horizontal scroll
- Highlight today
- Allow tap to view daily detail

## Step 7.5: Recipe Detail Screen
- Display full-screen recipe image
- Show recipe title and description
- List ingredients with quantities
- Display step-by-step cooking instructions
- Show nutrition breakdown (calories, protein, carbs, fats)
- Add "Replace" button
- Include "Add to favorites" option (optional)

## Step 7.6: Replace Meal Flow
- Create replacement request dialog
- Allow specifying replacement criteria
- Call AI service to generate alternative
- Show loading state
- Replace in meal plan
- Update UI

## Step 7.7: Shopping List Screen
- Auto-generate from weekly meal plan
- Group ingredients by category (Produce, Dairy, Meat, etc.)
- Display checkbox list
- Add quantities
- Implement check/uncheck functionality
- Add "Clear completed" action
- Support manual add/edit/delete

## Step 7.8: Shopping List BLoC
- Create `ShoppingListBloc` with states
- Implement events for CRUD operations
- Sync with meal plans
- Save to local storage

---

# Phase 8: Workout Planning Features
**Duration:** 5-6 days
**Goal:** Build workout planning and player features

## Step 8.1: Workout Plan Generator Screen
- Create workout request form
- Add muscle focus selector (optional)
- Include duration preference
- Add weekly plan toggle
- Show "Generate" button with loading

## Step 8.2: Workout Plan BLoC
- Create `WorkoutPlanBloc` with states:
  - `WorkoutPlanInitial`
  - `WorkoutPlanGenerating`
  - `WorkoutPlanGenerated`
  - `WorkoutPlanError`
- Implement events:
  - `GenerateWorkoutPlan`
  - `SaveWorkoutPlan`
  - `LoadWorkoutPlan`
  - `RegenerateWorkout`
- Call AI service use cases

## Step 8.3: Workout Routine Screen
- Display workout plan for the day
- List exercises with:
  - Exercise name
  - Reps/Sets or Duration
  - Rest time
  - Instructions/Tips
  - Optional GIF/video
- Add "Start Workout" button
- Show estimated duration

## Step 8.4: Workout Player Screen
- Create step-by-step workout player
- Display current exercise with large visual
- Show timer for duration-based exercises
- Display rep/set counter
- Add rest timer between sets
- Include previous/next navigation
- Add pause/resume functionality
- Show overall progress

## Step 8.5: Workout Timer Component
- Implement countdown timer
- Add visual progress indicator (circular or linear)
- Include sound cues (start, stop, halfway)
- Add haptic feedback
- Handle background timer

## Step 8.6: Workout Player BLoC
- Create `WorkoutPlayerBloc` with states:
  - `WorkoutPlayerReady`
  - `WorkoutPlayerRunning`
  - `WorkoutPlayerPaused`
  - `WorkoutPlayerResting`
  - `WorkoutPlayerCompleted`
- Implement events:
  - `StartWorkout`
  - `PauseWorkout`
  - `ResumeWorkout`
  - `NextExercise`
  - `PreviousExercise`
  - `CompleteWorkout`
- Track workout progress
- Save completion status

## Step 8.7: Workout History (Optional)
- Create workout history screen
- Display completed workouts
- Show statistics (duration, calories burned)
- Add calendar view

---

# Phase 9: Additional Features
**Duration:** 3-4 days
**Goal:** Implement profile, settings, and utilities

## Step 9.1: Profile Screen
- Display user information
- Show current preferences summary
- Add "Edit Preferences" button
- Include stats (meals planned, workouts completed)
- Add profile picture option

## Step 9.2: Edit Preferences Screen
- Reuse onboarding screens for editing
- Pre-fill current values
- Add save button
- Show confirmation dialog
- Regenerate plans if needed

## Step 9.3: Settings Screen
- Create settings categories:
  - Theme (Light/Dark/System)
  - AI Provider Configuration
  - Data Mode (Offline/Firebase/Supabase)
  - Notifications
  - Units (Metric/Imperial)
  - Language (if multi-language)
- Add API key input fields (masked)
- Include test connection button
- Add clear cache option

## Step 9.4: Settings BLoC
- Create `SettingsBloc` with states
- Implement events:
  - `ChangeTheme`
  - `SetAIProvider`
  - `SaveAPIKey`
  - `TestAIConnection`
  - `ChangeDataMode`
  - `ClearCache`
- Save to local storage
- Apply changes immediately

## Step 9.5: App Info Screen
- Display app version
- Add "About" information
- Include licenses
- Add privacy policy link
- Include terms of service link
- Add developer credits

## Step 9.6: Bottom Navigation
- Create bottom navigation bar
- Add navigation items:
  - Home
  - Meal Plans
  - Workouts
  - Profile
- Implement navigation logic
- Add selected state indicators
- Handle deep linking

---

# Phase 10: Polish & Testing
**Duration:** 4-5 days
**Goal:** Refine UI/UX, test, and prepare for release

## Step 10.1: UI/UX Polish
- Review all screens for consistency
- Add smooth transitions and animations
- Implement skeleton loaders
- Add empty states with illustrations
- Improve error messages with actions
- Add success feedback (snackbars, animations)
- Ensure responsive design (tablet support)
- Test dark mode on all screens

## Step 10.2: Performance Optimization
- Implement image caching
- Add pagination for lists
- Optimize BLoC rebuilds
- Reduce unnecessary API calls
- Implement debouncing for search/inputs
- Analyze app size and reduce if needed
- Test memory usage

## Step 10.3: Offline Support
- Implement offline detection
- Add offline mode banner
- Cache AI responses
- Queue sync operations
- Handle conflicts
- Test airplane mode scenarios

## Step 10.4: Testing
- Write unit tests for:
  - Models and entities
  - Repositories
  - Use cases
  - BLoCs
- Write widget tests for:
  - Custom widgets
  - Critical screens
- Write integration tests for:
  - Onboarding flow
  - Meal plan generation
  - Workout plan generation
- Manual testing on:
  - Multiple devices (phones, tablets)
  - Different screen sizes
  - Both platforms (iOS, Android)

## Step 10.5: Documentation
- Write comprehensive README.md
- Create SETUP.md for buyers
- Document AI provider setup
- Add code comments
- Create API key configuration guide
- Document customization points
- Add screenshots and GIFs

## Step 10.6: Template Preparation
- Remove test data and API keys
- Add placeholder .env.example
- Create sample configurations
- Add licensing information
- Prepare demo video
- Create feature list
- Prepare marketing materials

## Step 10.7: Security & Privacy
- Secure API key storage
- Implement API key validation
- Add rate limiting
- Sanitize user inputs
- Implement data encryption for sensitive data
- Add privacy controls
- Create data export/delete features

## Step 10.8: Build & Release Preparation
- Configure build scripts
- Set up CI/CD (optional)
- Test release builds
- Generate app bundles
- Test on physical devices
- Prepare app store assets
- Write release notes

---

# Implementation Checklist

## Phase 1: Project Setup ✓
- [ ] Create Flutter project
- [ ] Configure pubspec.yaml with dependencies
- [ ] Set up folder structure
- [ ] Configure Firebase
- [ ] Set up environment variables
- [ ] Configure app icons and splash screen
- [ ] Initialize Git repository

## Phase 2: Core Architecture ✓
- [ ] Create app configuration
- [ ] Implement theme system
- [ ] Define custom exceptions
- [ ] Create failure classes
- [ ] Set up dependency injection
- [ ] Implement navigation system
- [ ] Create route generator

## Phase 3: Data Layer ✓
- [ ] Define all domain entities
- [ ] Create data models with JSON serialization
- [ ] Implement Hive local data source
- [ ] Implement Firebase remote data source
- [ ] Implement Supabase remote data source
- [ ] Create repository interfaces
- [ ] Implement concrete repositories
- [ ] Add data mode switching

## Phase 4: AI Integration ✓
- [ ] Define AI service interfaces
- [ ] Create AI request/response models
- [ ] Implement OpenAI service
- [ ] Implement Gemini service
- [ ] Implement Claude service
- [ ] Create mock AI service
- [ ] Build AI provider adapter
- [ ] Add API key configuration

## Phase 5: Onboarding Flow ✓
- [ ] Create splash screen
- [ ] Build welcome screen
- [ ] Implement health goal selection
- [ ] Implement diet type selection
- [ ] Implement allergy selection
- [ ] Implement workout level selection
- [ ] Implement workout type selection
- [ ] Create onboarding BLoC
- [ ] Handle navigation flow

## Phase 6: Home Dashboard ✓
- [ ] Design dashboard layout
- [ ] Create calorie widget
- [ ] Build meal summary widget
- [ ] Build workout summary widget
- [ ] Implement quick actions
- [ ] Create dashboard BLoC
- [ ] Add refresh functionality
- [ ] Handle empty states

## Phase 7: Meal Planning Features ✓
- [ ] Create meal plan generator screen
- [ ] Implement meal plan BLoC
- [ ] Build daily meal plan view
- [ ] Build weekly meal plan view
- [ ] Create recipe detail screen
- [ ] Implement replace meal flow
- [ ] Build shopping list screen
- [ ] Create shopping list BLoC
- [ ] Add auto-generation from meal plans

## Phase 8: Workout Planning Features ✓
- [ ] Create workout generator screen
- [ ] Implement workout plan BLoC
- [ ] Build workout routine screen
- [ ] Create workout player screen
- [ ] Implement workout timer
- [ ] Create workout player BLoC
- [ ] Add sound cues and haptics
- [ ] Build workout history (optional)

## Phase 9: Additional Features ✓
- [ ] Create profile screen
- [ ] Build edit preferences screen
- [ ] Implement settings screen
- [ ] Create settings BLoC
- [ ] Build app info screen
- [ ] Implement bottom navigation
- [ ] Handle deep linking

## Phase 10: Polish & Testing ✓
- [ ] Polish UI/UX across all screens
- [ ] Add animations and transitions
- [ ] Optimize performance
- [ ] Implement offline support
- [ ] Write unit tests
- [ ] Write widget tests
- [ ] Write integration tests
- [ ] Manual testing on devices
- [ ] Create documentation
- [ ] Prepare template for buyers
- [ ] Implement security measures
- [ ] Configure release builds

---

# Estimated Timeline

| Phase | Duration | Dependencies |
|-------|----------|--------------|
| Phase 1: Project Setup | 1-2 days | None |
| Phase 2: Core Architecture | 2-3 days | Phase 1 |
| Phase 3: Data Layer | 3-4 days | Phase 2 |
| Phase 4: AI Integration | 3-4 days | Phase 3 |
| Phase 5: Onboarding Flow | 3-4 days | Phase 2, 3 |
| Phase 6: Home Dashboard | 4-5 days | Phase 3, 4 |
| Phase 7: Meal Planning | 5-6 days | Phase 4, 6 |
| Phase 8: Workout Planning | 5-6 days | Phase 4, 6 |
| Phase 9: Additional Features | 3-4 days | Phase 3, 5 |
| Phase 10: Polish & Testing | 4-5 days | All phases |

**Total Estimated Duration:** 33-43 days (6-8 weeks)

---

# Success Criteria

- [ ] All core features from PRD implemented
- [ ] Clean architecture properly implemented
- [ ] All three data modes working (Offline, Firebase, Supabase)
- [ ] All three AI providers working (OpenAI, Gemini, Claude)
- [ ] Smooth 60fps animations
- [ ] Comprehensive documentation
- [ ] Test coverage > 70%
- [ ] No critical bugs
- [ ] Builds successfully on iOS and Android
- [ ] Template ready for customization

---

# Notes for Developers

## Critical Implementation Points
1. **AI Provider Abstraction**: Ensure the AI adapter is truly provider-agnostic
2. **Data Mode Switching**: Make it seamless to switch between offline/Firebase/Supabase
3. **API Key Security**: Never hardcode keys, always use secure storage
4. **Offline First**: App should work without internet connection
5. **Customization**: Make UI/UX easy to customize (theme, colors, fonts)

## Customization Guide
Template buyers can easily customize:
- Colors and theme in `theme/` folder
- AI prompts in AI service implementations
- UI components in `widgets/` folder
- Navigation flow in route generator
- Data models by extending entities

## Best Practices
- Follow Flutter style guide
- Use meaningful variable names
- Comment complex logic
- Keep widgets small and focused
- Separate business logic from UI
- Use constants for magic numbers
- Handle all error cases
- Test on real devices

## Lucide Icons Usage Guide

### Why Lucide Icons?
- **546+ modern, minimal icons** perfect for health/fitness apps
- **6 stroke weights** (100-600) for visual hierarchy
- **Consistent design** across all icons
- **RTL support** for internationalization

### Common Usage Patterns
```dart
// Basic icon
Icon(LucideIcons.heart)

// With stroke width (100-600)
Icon(
  LucideIcons.activity,
  size: 24,
  strokeWidth: 2.5, // Use 1.5-3 for different weights
)

// Fitness app icons you'll use:
LucideIcons.activity         // Workout/exercise
LucideIcons.dumbbell         // Strength training
LucideIcons.flame            // Calories
LucideIcons.apple            // Food/nutrition
LucideIcons.utensils         // Meals
LucideIcons.shoppingCart     // Shopping list
LucideIcons.clock            // Timer
LucideIcons.trendingUp       // Progress
LucideIcons.barChart         // Statistics
LucideIcons.checkCircle      // Completed
LucideIcons.user             // Profile
LucideIcons.settings         // Settings
```

### Stroke Weight Guidelines
```dart
// Light (strokeWidth: 1.5) - Subtle, backgrounds
Icon(LucideIcons.heart, strokeWidth: 1.5)

// Regular (strokeWidth: 2) - Default, body content
Icon(LucideIcons.utensils, strokeWidth: 2)

// Medium (strokeWidth: 2.5) - Active states
Icon(LucideIcons.activity, strokeWidth: 2.5)

// Bold (strokeWidth: 3) - CTAs, emphasis
Icon(LucideIcons.flame, strokeWidth: 3)
```

---

## Injectable Quick Reference

### Common Annotations
```dart
// Singleton (created once, lives for app lifetime)
@singleton
class UserRepository implements IUserRepository { }

// Lazy Singleton (created on first use)
@lazySingleton
class AIMealService { }

// Injectable (default, transient)
@injectable
class GetMealPlanUseCase { }

// Factory (new instance every time)
@injectable
class DashboardBloc { }
```

### Module Example (for third-party dependencies)
```dart
@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio(BaseOptions(
    baseUrl: Env.baseUrl,
    connectTimeout: const Duration(seconds: 30),
  ));

  @preResolve // For async initialization
  Future<Box> get hive => Hive.openBox('app_box');
}
```

### Environment-based Registration
```dart
// Only in dev environment
@dev
@singleton
class MockAIService implements AIMealService { }

// Only in prod
@prod
@singleton
class OpenAIService implements AIMealService { }
```

### Usage in main.dart
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(); // Generated by injectable
  runApp(MyApp());
}
```

---

**End of Implementation Plan**
