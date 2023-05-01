import pandas as pd
import json

classes = ["10A", "10B", "10C", "11A", "11B", "11C"]
days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
lessons = ["Lesson 1", "Lesson 2", "Lesson 3", "Lesson 4", "Lesson 5"]

def read_timetables_from_excel(file_name):
    timetables = {}
    with pd.ExcelFile(file_name) as xls:
        for cls in classes:
            timetable = pd.read_excel(xls, cls, index_col=0)
            timetables[cls] = timetable
    return timetables

def convert_timetable_to_json(timetables):
    json_data = []

    for cls, timetable in timetables.items():
        class_timetable = {"class": cls, "timetable": {}}

        for day in days:
            day_lessons = []
            for lesson in lessons:
                cell = timetable.at[day, lesson]
                subject, room, teacher = cell.split(" - ")
                room_number = room.split()[-1]
                teacher_name = teacher[9:]
                day_lessons.append({"subject": subject, "room": room_number, "teacher": teacher_name})

            class_timetable["timetable"][day] = day_lessons

        json_data.append(class_timetable)

    return json_data

timetables = read_timetables_from_excel("school_timetables_with_room.xlsx")
json_data = convert_timetable_to_json(timetables)

with open("school_timetables_with_room.json", "w", encoding="utf-8") as json_file:
    json.dump(json_data, json_file, ensure_ascii=False, indent=2)

