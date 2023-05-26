import os

folder_path = "./"
source_path = "./screenshot/"
image_extensions = [".jpg", ".jpeg", ".png", ".gif"]

with open("./README.md", "w") as readme:
    for filename in os.listdir(folder_path):
        if any(ext in filename.lower() for ext in image_extensions):
            readme.write(f"![{filename}]({os.path.join(source_path, filename)})\n")
