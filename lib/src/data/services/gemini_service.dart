import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fiteats/src/core/config/app_config.dart';
import 'package:fiteats/src/core/errors/exceptions.dart';
import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/domain/entities/meal_plan.dart';
import 'package:fiteats/src/domain/entities/workout_plan.dart';
import 'package:fiteats/src/domain/services/ai_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AIService, env: ['gemini'])
class GeminiService implements AIService {
  GeminiService(this._dio);

  final Dio _dio;
  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta';

  @override
  String get providerName => 'Google Gemini';

  @override
  Future<Either<Failure, MealPlan>> generateMealPlan({
    required String userId,
    required DateTime date,
    required int calorieTarget,
    required List<String> dietaryPreferences,
    required List<String> allergies,
  }) async {
    try {
      final prompt = '''
Generate a detailed meal plan for one day with the following requirements:
- Calorie target: $calorieTarget kcal
- Dietary preferences: ${dietaryPreferences.join(', ')}
- Allergies: ${allergies.join(', ')}

Please provide:
1. Breakfast
2. Morning Snack
3. Lunch
4. Afternoon Snack
5. Dinner

For each meal, include:
- Meal name
- Description
- Ingredients list
- Cooking instructions
- Nutritional information (calories, protein, carbs, fats, fiber, sugar, sodium)
- Prep time and cook time in minutes

Return the response in JSON format.
''';

      final response = await _dio.post(
        '$_baseUrl/models/gemini-pro:generateContent?key=${AppConfig.geminiKey}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'contents': [
            {
              'parts': [
                {'text': prompt},
              ],
            },
          ],
          'generationConfig': {
            'temperature': 0.7,
            'topK': 40,
            'topP': 0.95,
            'maxOutputTokens': 2048,
          },
        },
      );

      // TODO: Parse Gemini response and convert to MealPlan entity
      // For now, return not implemented
      return Left(
        Failure.notImplemented(
          message: 'Gemini meal plan parsing not yet implemented',
        ),
      );
    } on DioException catch (e) {
      return Left(
        Failure.ai(
          message: 'Gemini API error: ${e.message}',
          provider: providerName,
        ),
      );
    } on AIException catch (e) {
      return Left(
        Failure.ai(
          message: e.message,
          provider: providerName,
        ),
      );
    } catch (e) {
      return Left(
        Failure.unexpected(
          message: 'Unexpected error in Gemini service: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, WorkoutPlan>> generateWorkoutPlan({
    required String userId,
    required DateTime date,
    required String level,
    required String type,
    required int duration,
  }) async {
    try {
      final prompt = '''
Generate a detailed workout plan with the following requirements:
- Level: $level
- Type: $type
- Duration: $duration minutes

Please provide:
1. Workout title
2. Workout description
3. List of exercises with:
   - Exercise name
   - Description
   - Type (warmup, cardio, strength, flexibility, cooldown)
   - Sets and reps (for strength exercises)
   - Duration in minutes (for cardio/warmup/cooldown)
   - Rest time between sets
   - Muscle groups targeted
   - Equipment needed (if any)

Return the response in JSON format.
''';

      final response = await _dio.post(
        '$_baseUrl/models/gemini-pro:generateContent?key=${AppConfig.geminiKey}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'contents': [
            {
              'parts': [
                {'text': prompt},
              ],
            },
          ],
          'generationConfig': {
            'temperature': 0.7,
            'topK': 40,
            'topP': 0.95,
            'maxOutputTokens': 2048,
          },
        },
      );

      // TODO: Parse Gemini response and convert to WorkoutPlan entity
      // For now, return not implemented
      return Left(
        Failure.notImplemented(
          message: 'Gemini workout plan parsing not yet implemented',
        ),
      );
    } on DioException catch (e) {
      return Left(
        Failure.ai(
          message: 'Gemini API error: ${e.message}',
          provider: providerName,
        ),
      );
    } on AIException catch (e) {
      return Left(
        Failure.ai(
          message: e.message,
          provider: providerName,
        ),
      );
    } catch (e) {
      return Left(
        Failure.unexpected(
          message: 'Unexpected error in Gemini service: $e',
        ),
      );
    }
  }
}
