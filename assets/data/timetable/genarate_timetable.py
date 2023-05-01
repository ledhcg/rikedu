# Luôn đảm bảm số lượng môn học: total_of_subject_counts = lesson x days

import pandas as pd
import random
from openpyxl import Workbook

classes = ["10А", "10Б", "10В", "11А", "11Б", "11В"]

days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]

lessons = ["Lesson 1", "Lesson 2", "Lesson 3", "Lesson 4", "Lesson 5", "Lesson 6", "Lesson 7"]

subjects = ["Русский язык", "Литература", "Математика", "Физика", "Химия", "Биология", "Информатика", "Иностранный язык", "История", "Обществознание", "География", "Физическая культура", "X"]

subject_counts = {"Русский язык": 4, "Литература": 3, "Математика": 6, "Физика": 3, "Химия": 3, "Биология": 2, "Информатика": 3, "Иностранный язык": 2, "История": 2, "Обществознание": 2, "География": 2, "Физическая культура": 2, "X":1}

rooms = {
    "Русский язык": [205, 213, 108, 101, 206, 110, 204],
    "Литература": [103, 105, 202, 209, 207, 210, 212],
    "Математика": [212, 108, 101, 205, 104, 205, 109],
    "Физика": [111, 114, 113, 110],
    "Химия": [209, 211, 212, 213],
    "Биология": [309, 310, 309, 310],
    "Информатика": [107, 107, 107, 107, 107],
    "Иностранный язык": [203, 205, 207, 206, 208, 206],
    "История": [111, 110, 114],
    "Обществознание": [212, 213, 214],
    "География": [111, 109],
    "Физическая культура": [111, 112, 109, 112],
    "X": [000],
}

teacher_of_subjects = {
    'Русский язык': ['Михаил С.К.', 'Екатерина А.П.', 'Дмитрий А.Ф.', 'Ольга В.С.', 'Александр И.Р.', 'Анна С.И.'],
    'Литература': ['Илья В.М.', 'Владимир В.П.', 'Светлана А.К.', 'Надежда С.Б.', 'Татьяна Д.Н.', 'Мария А.К.', 'Петр И.С.', 'Георгий Н.М.'],
    'Математика': ['Константин В.Л.', 'Сергей А.Т.', 'Алексей С.К.', 'Евгения О.П.', 'Игорь П.В.', 'Марина Г.Б.'],
    'Физика': ['Роман А.Д.', 'Людмила А.С.', 'Игорь В.Н.'],
    'Химия': ['Оксана М.С.', 'Елена С.Т.', 'Анастасия А.Ф.'],
    'Биология': ['Светлана А.К.', 'Андрей П.С.'],
    'Информатика': ['Анастасия А.М.', 'Алёна В.Л.', 'Игорь В.Н.'],
    'Иностранный язык': ['Юлия Н.В.', 'Елена В.К.'],
    'История': ['Елена В.К.', 'Наталья Д.З.'],
    'Обществознание': ['Наталья Д.З.', 'Анна С.И.'],
    'География': ['Василий И.М.', 'Марина Г.Б.'],
    'Физическая культура': ['Светлана А.К.', 'Юлия Н.В.'],
    'X': ["X"]
}

def get_random_room(subject):
    room = random.choice(rooms[subject])
    return f"Room {room}"

def get_random_teacher(subject):
    teacher = random.choice(teacher_of_subjects[subject])
    return f"Teacher: {teacher}"

def generate_timetable():
    timetable_subjects = [subject for subject, count in subject_counts.items() for _ in range(count)]
    random.shuffle(timetable_subjects)

    timetable = pd.DataFrame(index=days, columns=lessons)
    for idx, subject in enumerate(timetable_subjects):
        day, lesson = divmod(idx, len(lessons))
        room_subject = f"{subject} - {get_random_room(subject)} - {get_random_teacher(subject)}"
        timetable.iat[day, lesson] = room_subject

    return timetable

def export_to_excel(timetables):
    with pd.ExcelWriter("school_timetables.xlsx") as writer:
        for cls, timetable in timetables.items():
            timetable.to_excel(writer, sheet_name=cls)

timetables = {cls: generate_timetable() for cls in classes}
export_to_excel(timetables)
