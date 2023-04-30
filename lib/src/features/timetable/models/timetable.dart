class TimetableData {
  static final Map<String, Map<String, String>> _data = {
    "Monday": {
      "Lesson 1": "Language",
      "Lesson 2": "Biology",
      "Lesson 3": "Language",
      "Lesson 4": "Chemistry",
      "Lesson 5": "X"
    },
    "Tuesday": {
      "Lesson 1": "X",
      "Lesson 2": "Math",
      "Lesson 3": "Math",
      "Lesson 4": "Math",
      "Lesson 5": "Language"
    },
    "Wednesday": {
      "Lesson 1": "History",
      "Lesson 2": "Language",
      "Lesson 3": "Physics",
      "Lesson 4": "Language",
      "Lesson 5": "Math"
    },
    "Thursday": {
      "Lesson 1": "Chemistry",
      "Lesson 2": "Geography",
      "Lesson 3": "Physics",
      "Lesson 4": "Math",
      "Lesson 5": "Language"
    },
    "Friday": {
      "Lesson 1": "X",
      "Lesson 2": "Math",
      "Lesson 3": "Math",
      "Lesson 4": "Language",
      "Lesson 5": "Biology"
    }
  };

  static Map<String, String> getLessonsForDay(String day) {
    return _data[day] ?? {};
  }
}
