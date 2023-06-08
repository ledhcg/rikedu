import json
from unidecode import unidecode
import numpy as np


with open('constants/list_students_parents.txt', 'r', encoding="utf-8") as file:
    lines = file.readlines()

list_students_parents = [line.rstrip() for line in lines]

def convert_students_parents(students_parents):
    list_all = []

    student_usernames = []
    parent_usernames = []
    for data in students_parents:
        student, student_gender, parent = data.split(" - ")
        
        # STUDENT
        student_first_name, student_middle_name, student_last_name = student.split(" ")
        student_short_name = student_last_name + " " + student_first_name[0] + "." + student_middle_name[0] + "."
        student_first_name = student_first_name + " " + student_middle_name
        
        student_username = student_short_name.replace(" ", "")
        student_username = ''.join(filter(lambda x: x.isalpha() or x.isspace(), student_username)).lower()

        # Chuyển đổi sang ký tự la tinh và xóa ký tự ' trong 1 vài tên
        student_username = unidecode(student_username).replace("'", "")
        
        # Xử lý trùng lặp
        student_count = 1
        student_username_source = student_username
        while student_username in student_usernames:
            student_count += 1
            student_username = f"{student_username_source}{student_count}"

        student_usernames.append(student_username)


        # PARENT
        parent_first_name, parent_middle_name, parent_last_name = parent.split(" ")
        parent_short_name = parent_last_name + " " + parent_first_name[0] + "." + parent_middle_name[0] + "."
        parent_first_name = parent_first_name + " " + parent_middle_name
        
        parent_username = parent_short_name.replace(" ", "")
        parent_username = ''.join(filter(lambda x: x.isalpha() or x.isspace(), parent_username)).lower()

        # Chuyển đổi sang ký tự la tinh và xóa ký tự ' trong 1 vài tên
        parent_username = unidecode(parent_username).replace("'", "")
        
        # Xử lý trùng lặp
        parent_count = 1
        parent_username_source = parent_username
        while parent_username in parent_usernames:
            parent_count += 1
            parent_username = f"{parent_username_source}{parent_count}"

        parent_usernames.append(parent_username)

        list_all.append({
            "student": {
                "firstName": student_first_name,
                "lastName": student_last_name,
                "shortName": student_short_name,
                "gender": student_gender,
                "username": student_username
            },
            "parent": {
                "firstName": parent_first_name,
                "lastName": parent_last_name,
                "shortName": parent_short_name,
                "gender": 'женский',
                "username": parent_username
            }
        })

    return list_all


students_parents = convert_students_parents(list_students_parents)

with open("students_parents.json", "w", encoding="utf-8") as f:
    json.dump(students_parents, f, indent=2, ensure_ascii=False)