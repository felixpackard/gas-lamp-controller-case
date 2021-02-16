# Imports
import os
import configparser

# Read config
config = configparser.ConfigParser()
config.read("config.ini")

# Create out directory if it doesn't exist
os.chdir("../")
if not os.path.exists("out"):
    os.mkdir("out")

# Build all modules in parts/
for file in os.listdir("parts"):
    filename = os.path.splitext(file)[0]
    openscad_path = config.get("build", "openscad_path")
    os.system(f"{openscad_path} -o out/{filename}.stl parts/{file}")
