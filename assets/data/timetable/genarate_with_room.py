import pandas as pd
import random
from openpyxl import Workbook

classes = ["10A", "10B", "10C", "11A", "11B", "11C"]
days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
lessons = ["Lesson 1", "Lesson 2", "Lesson 3", "Lesson 4", "Lesson 5"]
subjects = ["Math", "Language", "Physics", "Chemistry", "Biology", "History", "Geography", "X"]

subject_counts = {"Math": 7, "Language": 7, "Physics": 2, "Chemistry": 2, "Biology": 2, "History": 1, "Geography": 1, "X": 3}

rooms = {
    "Math": [100, 101, 102, 103, 104, 105, 106, 107, 108],
    "Language": [200, 201, 202, 203, 204, 205, 206, 207, 208],
    "Physics": [109, 110, 111, 112, 113, 114],
    "Chemistry": [209, 210, 211, 212, 213, 214],
    "Biology": [309, 310],
    "History": [318, 319],
    "Geography": [315, 316],
    "X": [000],
}

def get_random_room(subject):
    room = random.choice(rooms[subject])
    return f"Room {room}"

def generate_timetable():
    timetable_subjects = [subject for subject, count in subject_counts.items() for _ in range(count)]
    random.shuffle(timetable_subjects)

    timetable = pd.DataFrame(index=days, columns=lessons)
    for idx, subject in enumerate(timetable_subjects):
        day, lesson = divmod(idx, len(lessons))
        room_subject = f"{subject} - {get_random_room(subject)}"
        timetable.iat[day, lesson] = room_subject

    return timetable

def export_to_excel(timetables):
    with pd.ExcelWriter("school_timetables_with_room.xlsx") as writer:
        for cls, timetable in timetables.items():
            timetable.to_excel(writer, sheet_name=cls)

timetables = {cls: generate_timetable() for cls in classes}
export_to_excel(timetables)
