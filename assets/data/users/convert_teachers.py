import json
from unidecode import unidecode
import numpy as np


with open('constants/list_teachers.txt', 'r', encoding="utf-8") as file:
    lines = file.readlines()

list_teachers = [line.rstrip() for line in lines]

def convert_teachers(teachers):
    usernames = []
    for data in teachers:
        full_name, gender, mother = data.split(" - ")
        first_name, middle_name, last_name = full_name.split(" ")
        short_name = last_name + " " + first_name[0] + "." + middle_name[0] + "."
        first_name = first_name + " " + middle_name
        
        # Chuyển shortname thành username, loại bỏ dấu chấm và khoảng cách
        username = short_name.replace(" ", "")
        username = ''.join(filter(lambda x: x.isalpha() or x.isspace(), username)).lower()

        # Chuyển đổi sang ký tự la tinh và xóa ký tự ' trong 1 vài tên
        username = unidecode(username).replace("'", "")
        
        # Xử lý trùng lặp
        count = 1
        username_source = username
        while username in usernames:
            count += 1
            username = f"{username_source}{count}"

        usernames.append(username)

        yield {
            "firstName": first_name,
            "lastName": last_name,
            "shortName": short_name,
            "gender": gender,
            "username": username
        }

teachers = list(convert_teachers(list_teachers))

with open("teachers.json", "w", encoding="utf-8") as f:
    json.dump(teachers, f, indent=2, ensure_ascii=False)