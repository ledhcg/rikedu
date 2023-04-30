import pandas as pd
import random
from openpyxl import Workbook

classes = ["10A", "10B", "10C", "11A", "11B", "11C"]
days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
lessons = ["Lesson 1", "Lesson 2", "Lesson 3", "Lesson 4", "Lesson 5"]
subjects = ["Math", "Language", "Physics", "Chemistry", "Biology", "History", "Geography", "X"]

subject_counts = {"Math": 7, "Language": 7, "Physics": 2, "Chemistry": 2, "Biology": 2, "History": 1, "Geography": 1, "X": 3}

def generate_timetable():
    timetable_subjects = [subject for subject, count in subject_counts.items() for _ in range(count)]
    random.shuffle(timetable_subjects)

    timetable = pd.DataFrame(index=days, columns=lessons)
    for idx, subject in enumerate(timetable_subjects):
        day, lesson = divmod(idx, len(lessons))
        timetable.iat[day, lesson] = subject

    return timetable

def export_to_excel(timetables):
    with pd.ExcelWriter("school_timetables.xlsx") as writer:
        for cls, timetable in timetables.items():
            timetable.to_excel(writer, sheet_name=cls)

timetables = {cls: generate_timetable() for cls in classes}
export_to_excel(timetables)
