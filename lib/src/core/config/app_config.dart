import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Application configuration based on environment variables
class AppConfig {
  AppConfig._();

  static late final String appName;
  static late final String appVersion;
  static late final String environment;

  /// AI Configuration
  static late final AIProvider aiProvider;
  static late final String openAiApiKey;
  static late final String openAiModel;
  static late final String geminiApiKey;
  static late final String geminiModel;
  static late final String claudeApiKey;
  static late final String claudeModel;

  /// Backend Configuration
  static late final bool firebaseEnabled;
  static late final bool supabaseEnabled;
  static late final String supabaseUrl;
  static late final String supabaseAnonKey;

  /// Initialize configuration from .env file
  static Future<void> initialize() async {
    await dotenv.load();

    // App Info
    appName = dotenv.get('APP_NAME', fallback: 'FitEats AI');
    appVersion = dotenv.get('APP_VERSION', fallback: '1.0.0');
    environment = dotenv.get('ENVIRONMENT', fallback: 'development');

    // AI Provider
    final provider = dotenv.get('AI_PROVIDER', fallback: 'mock').toLowerCase();
    aiProvider = AIProvider.fromString(provider);

    // OpenAI
    openAiApiKey = dotenv.get('OPENAI_API_KEY', fallback: '');
    openAiModel = dotenv.get('OPENAI_MODEL', fallback: 'gpt-4');

    // Gemini
    geminiApiKey = dotenv.get('GEMINI_API_KEY', fallback: '');
    geminiModel = dotenv.get('GEMINI_MODEL', fallback: 'gemini-pro');

    // Claude
    claudeApiKey = dotenv.get('CLAUDE_API_KEY', fallback: '');
    claudeModel = dotenv.get(
      'CLAUDE_MODEL',
      fallback: 'claude-3-opus-20240229',
    );

    // Backend
    firebaseEnabled =
        dotenv.get('FIREBASE_ENABLED', fallback: 'false') == 'true';
    supabaseEnabled =
        dotenv.get('SUPABASE_ENABLED', fallback: 'false') == 'true';
    supabaseUrl = dotenv.get('SUPABASE_URL', fallback: '');
    supabaseAnonKey = dotenv.get('SUPABASE_ANON_KEY', fallback: '');
  }

  /// Check if running in development mode
  static bool get isDevelopment => environment == 'development';

  /// Check if running in production mode
  static bool get isProduction => environment == 'production';

  /// Check if running in staging mode
  static bool get isStaging => environment == 'staging';

  /// Get current AI provider API key
  static String get currentAiApiKey {
    switch (aiProvider) {
      case AIProvider.openai:
        return openAiApiKey;
      case AIProvider.gemini:
        return geminiApiKey;
      case AIProvider.claude:
        return claudeApiKey;
      case AIProvider.mock:
        return '';
    }
  }

  /// Get current AI model
  static String get currentAiModel {
    switch (aiProvider) {
      case AIProvider.openai:
        return openAiModel;
      case AIProvider.gemini:
        return geminiModel;
      case AIProvider.claude:
        return claudeModel;
      case AIProvider.mock:
        return 'mock';
    }
  }

  /// Check if AI provider is configured
  static bool get isAiConfigured {
    if (aiProvider == AIProvider.mock) return true;
    return currentAiApiKey.isNotEmpty;
  }

  /// Convenience getters for AI keys
  static String get openAIKey => openAiApiKey;
  static String get geminiKey => geminiApiKey;
  static String get claudeKey => claudeApiKey;
}

/// AI Provider enum
enum AIProvider {
  openai,
  gemini,
  claude,
  mock;

  static AIProvider fromString(String value) {
    switch (value.toLowerCase()) {
      case 'openai':
        return AIProvider.openai;
      case 'gemini':
        return AIProvider.gemini;
      case 'claude':
        return AIProvider.claude;
      case 'mock':
      default:
        return AIProvider.mock;
    }
  }

  String get name {
    switch (this) {
      case AIProvider.openai:
        return 'OpenAI';
      case AIProvider.gemini:
        return 'Gemini';
      case AIProvider.claude:
        return 'Claude';
      case AIProvider.mock:
        return 'Mock';
    }
  }
}
