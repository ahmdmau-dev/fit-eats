/// Base exception class
abstract class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Server exception - API errors
class ServerException extends AppException {
  const ServerException([super.message = 'Server error occurred']);
}

/// Cache exception - Local storage errors
class CacheException extends AppException {
  const CacheException([super.message = 'Cache error occurred']);
}

/// Network exception - Connectivity issues
class NetworkException extends AppException {
  const NetworkException([super.message = 'Network error occurred']);
}

/// AI exception - AI service errors
class AIException extends AppException {
  const AIException([super.message = 'AI service error occurred']);
}

/// Validation exception - Input validation errors
class ValidationException extends AppException {
  const ValidationException([super.message = 'Validation error occurred']);
}

/// Authentication exception - Auth errors
class AuthenticationException extends AppException {
  const AuthenticationException([super.message = 'Authentication failed']);
}

/// Authorization exception - Permission errors
class AuthorizationException extends AppException {
  const AuthorizationException([super.message = 'Authorization failed']);
}

/// Not found exception - Resource not found
class NotFoundException extends AppException {
  const NotFoundException([super.message = 'Resource not found']);
}

/// Timeout exception - Operation timed out
class TimeoutException extends AppException {
  const TimeoutException([super.message = 'Operation timed out']);
}

/// Rate limit exception - Too many requests
class RateLimitException extends AppException {
  const RateLimitException([super.message = 'Rate limit exceeded']);
}
