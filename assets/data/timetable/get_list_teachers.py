import numpy as np

# Mở file text
with open('constants/teachers.txt', 'r', encoding="utf-8") as file:
    # Đọc các dòng của file và lưu vào một list
    lines = file.readlines()

# Tạo một array từ list các dòng
array = [line.rstrip() for line in lines]

# Xuất ra array
print(array)
