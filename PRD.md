
# 📘 FitEats AI – Meal & Workout Planner (Flutter Template)
## Product Requirements Document (PRD)
**Version:** 1.0  
**Owner:** Ahmad Maulana  
**Last Updated:** 2025-11-24  

---

# 1. Overview
FitEats AI adalah aplikasi AI-powered meal & workout planner yang membantu pengguna membuat rencana makan dan latihan secara otomatis berdasarkan tujuan kesehatan, preferensi diet, alergi, dan tingkat kebugaran.

Aplikasi ini dirancang sebagai Flutter template premium yang dapat dibeli developer untuk dikustomisasi. Sistem AI dihubungkan melalui API pihak ketiga (OpenAI / Gemini / Claude), dengan implementasi AI adapter sehingga pembeli dapat memasang API key mereka sendiri.

Template ini tidak membutuhkan backend kompleks dan dapat berjalan dengan:
- Firebase

---

# 2. Goals

## 2.1 Primary Goals
- Menyediakan template AI-powered yang modern dan mudah dikustomisasi.  
- Menawarkan fitur meal plan dan workout plan yang dihasilkan melalui AI.  
- Memudahkan developer untuk:
  - Mengganti UI/UX
  - Mengubah logic
  - Mengatur AI provider
  - Menggunakan Firebase/Supabase secara opsional

## 2.2 Secondary Goals
- Memberikan pengalaman visual premium dan aesthetic.  
- Menggunakan clean architecture agar mudah dikembangkan dan diperluas.  
- Meminimalisir dependency supaya template fleksibel.

---

# 3. Out of Scope
- Tidak menyertakan atau menyediakan API Key AI.  
- Tidak menyediakan admin panel untuk input resep/workout.  
- Tidak menyediakan database resep statis bawaan.  
- Tidak menyediakan sistem subscription atau monetisasi.  

---

# 4. Target Users

## 4.1 End Users (Saat aplikasi dikustomisasi buyer)
- Pengguna yang ingin diet teratur.  
- Pengguna yang ingin latihan terstruktur.  
- Pemula hingga intermediate fitness.  

## 4.2 Buyer / Developer
- Developer Flutter  
- Indie Founder  
- Freelancer  
- Startup yang butuh MVP cepat  

---

# 5. Key Features

## 5.1 Onboarding & Personalization
User mengisi:
- Health Goal (Lose weight, gain muscle, maintain health)
- Diet Type (Normal, Vegan, Keto, Low-carb, Mediterranean)
- Allergies (Seafood, nuts, gluten, lactose, etc)
- Workout Level (Beginner, Intermediate, Advanced)
- Workout Type (Home, Gym, Mixed)

Data disimpan ke local (dan optional sync ke Firebase).

---

## 5.2 Home Dashboard
Menampilkan:
- Daily calorie goal
- Meal plan summary (Breakfast / Lunch / Dinner / Snack)
- Workout summary (routine of the day)
- Steps completed / progress indicator
- Quick actions:
- Generate Meal Plan
- Generate Workout Plan
- Regenerate Today
- Suggest Alternatives

---

## 5.3 AI Meal Plan Generator
Input:
- Goal
- Diet type
- Alergi
- Calories target cadangan (optional)

Output AI:
- 4–5 meals per day
- Ingredients list
- Cooking steps
- Nutrition breakdown
- Photo URL (optional via recipe API)
- Shopping list

User Can:
- Save / update meal plan
- Regenerate part of the day (e.g., dinner only)
- Replace individual recipe

---

## 5.4 Meal Plan View
- Daily view  
- Weekly view  
- Tap meal → recipe detail  

---

## 5.5 Recipe Detail
- Image  
- Name  
- Ingredients  
- Steps  
- Nutrition  
- Replace via AI  

---

## 5.6 Shopping List
- Auto-generate dari meal plan  
- Grouped by category  
- Checkbox list  

---

## 5.7 AI Workout Plan Generator
Input:
- Goal
- Workout level
- Workout type (Home/Gym)
- Muscle focus (optional)

Output:
- Workout plan for the day or week
- List of exercises
- Reps / Sets / Duration
- Rest time
- Tips

---

## 5.8 Workout Player
- Step-by-step  
- Timer  
- Progress tracker  
- Sound cues  

---

## 5.9 Profile Page
- Edit preferences  
- Theme settings  
- AI provider configuration  
- App info  

---

# 6. Technical Requirements

## 6.1 Architecture
- Flutter  
- BLoC  
- Clean Architecture  

---

## 6.2 AI Integration
Interface:

```dart
abstract class AIMealService {
  Future<MealPlan> generateMealPlan(MealPlanRequest req);
  Future<MealRecipe> generateRecipe(RecipeRequest req);
}
```

---

## 6.3 Data Options

Template mendukung 3 mode:

1. Offline-only
- Saved in Hive
- AI only through mock

2. Firebase mode
- Save user preferences
- Save meal plans
- Save workout plans

3. Supabase mode (optional)
- Similar structure

Buyer tinggal pilih mode.


---

## 6.4 Model Data
- UserPreference  
- MealPlan  
- Recipe  
- WorkoutPlan  
- WorkoutExercise  
- ShoppingListItem  

---

# 7. UI/UX Requirements

Style:
- Clean  
- Modern  
- Light gradient  
- Smooth transitions  

Screens:
- Splash  
- Onboarding  
- Goals setup  
- Diet setup  
- Allergy setup  
- Workout setup  
- Home dashboard  
- Meal plan  
- Recipe detail  
- Workout routine  
- Workout player  
- Shopping list  
- Profile  

---

# 8. Data Structures

Meal Plan (Daily):
```json
{
  "date": "2025-01-01",
  "meals": {
    "breakfast": {},
    "lunch": {},
    "dinner": {},
    "snack": {}
  }
}
```

Recipe:
```json
{
  "title": "Grilled Chicken Bowl",
  "calories": 480,
  "ingredients": ["Chicken", "Rice", "Broccoli"],
  "steps": ["Grill chicken", "Boil rice", "Serve"]
}
```

---

# 9. Non-Functional Requirements
- Load cepat  
- Animasi 60fps  
- Offline caching  
- Theme switching  
- Extensible  
- API key aman  

---

# 10. Future Expansion
- Subscription  
- Coach mode  
- Macro calculator  
- Community  
- Wearable integration  
