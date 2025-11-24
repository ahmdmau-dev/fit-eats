import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fiteats/src/core/config/app_config.dart';
import 'package:fiteats/src/core/errors/exceptions.dart';
import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/domain/entities/meal_plan.dart';
import 'package:fiteats/src/domain/entities/workout_plan.dart';
import 'package:fiteats/src/domain/services/ai_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AIService, env: ['openai'])
class OpenAIService implements AIService {
  OpenAIService(this._dio);

  final Dio _dio;
  static const String _baseUrl = 'https://api.openai.com/v1';

  @override
  String get providerName => 'OpenAI';

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
        '$_baseUrl/chat/completions',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConfig.openAIKey}',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'model': 'gpt-4-turbo-preview',
          'messages': [
            {
              'role': 'system',
              'content':
                  'You are a professional nutritionist and meal planning expert. Generate balanced, healthy meal plans.',
            },
            {'role': 'user', 'content': prompt},
          ],
          'temperature': 0.7,
        },
      );

      // TODO: Parse OpenAI response and convert to MealPlan entity
      // For now, return not implemented
      return Left(
        Failure.notImplemented(
          message: 'OpenAI meal plan parsing not yet implemented',
        ),
      );
    } on DioException catch (e) {
      return Left(
        Failure.ai(
          message: 'OpenAI API error: ${e.message}',
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
          message: 'Unexpected error in OpenAI service: $e',
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
        '$_baseUrl/chat/completions',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConfig.openAIKey}',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'model': 'gpt-4-turbo-preview',
          'messages': [
            {
              'role': 'system',
              'content':
                  'You are a professional fitness trainer and workout planning expert. Generate effective, safe workout plans.',
            },
            {'role': 'user', 'content': prompt},
          ],
          'temperature': 0.7,
        },
      );

      // TODO: Parse OpenAI response and convert to WorkoutPlan entity
      // For now, return not implemented
      return Left(
        Failure.notImplemented(
          message: 'OpenAI workout plan parsing not yet implemented',
        ),
      );
    } on DioException catch (e) {
      return Left(
        Failure.ai(
          message: 'OpenAI API error: ${e.message}',
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
          message: 'Unexpected error in OpenAI service: $e',
        ),
      );
    }
  }
}
