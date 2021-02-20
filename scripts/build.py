# Imports
import os
import configparser

# Globals
config = configparser.ConfigParser()


def setup() -> None:
    # Read config
    config.read("config.ini")

    # Create out directory if it doesn't exist
    os.chdir("../")
    if not os.path.exists("out"):
        os.mkdir("out")


def parts_to_stl() -> None:
    # Build all modules in parts/
    for file in os.listdir("parts"):
        filename = os.path.splitext(file)[0]

        print(f"[BUILDING] parts/{file} → out/{filename}.stl ...", end="")

        openscad_path = config.get("build", "openscad_path")
        os.system(f"{openscad_path} -o out/{filename}.stl parts/{file}")

        print(" [DONE]")

    print("\nAll parts have finished building. Check the output for errors.")


if __name__ == "__main__":
    setup()
    parts_to_stl()
