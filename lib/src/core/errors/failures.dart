import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Base failure class for error handling
@freezed
class Failure with _$Failure {
  const factory Failure.server({
    @Default('Server error occurred') String message,
    int? statusCode,
  }) = ServerFailure;

  const factory Failure.cache({
    @Default('Cache error occurred') String message,
  }) = CacheFailure;

  const factory Failure.network({
    @Default('Network error occurred') String message,
  }) = NetworkFailure;

  const factory Failure.ai({
    @Default('AI service error occurred') String message,
    String? provider,
  }) = AIFailure;

  const factory Failure.validation({
    @Default('Validation error occurred') String message,
    Map<String, String>? fieldErrors,
  }) = ValidationFailure;

  const factory Failure.authentication({
    @Default('Authentication failed') String message,
  }) = AuthenticationFailure;

  const factory Failure.authorization({
    @Default('Authorization failed') String message,
  }) = AuthorizationFailure;

  const factory Failure.notFound({
    @Default('Resource not found') String message,
  }) = NotFoundFailure;

  const factory Failure.timeout({
    @Default('Operation timed out') String message,
  }) = TimeoutFailure;

  const factory Failure.rateLimit({
    @Default('Rate limit exceeded') String message,
    int? retryAfter,
  }) = RateLimitFailure;

  const factory Failure.unknown({
    @Default('Unknown error occurred') String message,
  }) = UnknownFailure;

  const factory Failure.notImplemented({
    @Default('Feature not implemented') String message,
  }) = NotImplementedFailure;

  const factory Failure.unexpected({
    @Default('Unexpected error occurred') String message,
  }) = UnexpectedFailure;
}

/// Extension to get user-friendly error messages
extension FailureX on Failure {
  String get userMessage {
    return when(
      server: (message, statusCode) {
        if (statusCode != null) {
          switch (statusCode) {
            case 400:
              return 'Bad request. Please check your input.';
            case 401:
              return 'Please log in to continue.';
            case 403:
              return 'You don\'t have permission to perform this action.';
            case 404:
              return 'The requested resource was not found.';
            case 500:
              return 'Server error. Please try again later.';
            case 503:
              return 'Service temporarily unavailable.';
            default:
              return message;
          }
        }
        return 'Server error. Please try again.';
      },
      cache: (message) => 'Failed to access local data.',
      network: (message) => 'No internet connection. Please check your network.',
      ai: (message, provider) {
        final providerName = provider ?? 'AI service';
        return '$providerName is currently unavailable. Please try again.';
      },
      validation: (message, fieldErrors) {
        if (fieldErrors != null && fieldErrors.isNotEmpty) {
          return fieldErrors.values.first;
        }
        return 'Please check your input and try again.';
      },
      authentication: (message) => 'Please log in to continue.',
      authorization: (message) => 'You don\'t have permission to perform this action.',
      notFound: (message) => 'The requested item was not found.',
      timeout: (message) => 'Request timed out. Please try again.',
      rateLimit: (message, retryAfter) {
        if (retryAfter != null) {
          return 'Too many requests. Please try again in $retryAfter seconds.';
        }
        return 'Too many requests. Please try again later.';
      },
      unknown: (message) => 'Something went wrong. Please try again.',
      notImplemented: (message) => 'This feature is coming soon.',
      unexpected: (message) => 'An unexpected error occurred. Please try again.',
    );
  }
}
