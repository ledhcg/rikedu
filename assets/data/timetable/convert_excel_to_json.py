import pandas as pd
import json

classes = ["10A", "10B", "10C", "11A", "11B", "11C"]
days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
lessons = ["Lesson 1", "Lesson 2", "Lesson 3", "Lesson 4", "Lesson 5"]
subjects = ["Math", "Language", "Physics", "Chemistry", "Biology", "History", "Geography", "X"]

def read_excel_to_json():
    timetables = {}
    for cls in classes:
        df = pd.read_excel("school_timetables.xlsx", sheet_name=cls, index_col=0)
        timetable = {}
        for day in days:
            timetable[day] = {}
            for lesson in lessons:
                subject = df.loc[day, lesson]
                if not pd.isna(subject):
                    timetable[day][lesson] = subject
        timetables[cls] = timetable

    with open("school_timetables.json", "w") as outfile:
        json.dump(timetables, outfile, indent=2)

read_excel_to_json()
