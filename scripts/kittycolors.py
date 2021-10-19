import json
import sys


class JsonColors:

    def __init__(self, colors: dict):
        self.colors = colors["color"]
        self.background = colors["background"]
        self.foreground = colors["foreground"]


def parse_json(path: str):
    colors = {}

    with open(path, "r") as file:
        colors = json.loads(file.read())

    if "color" in colors:
        return JsonColors(colors)

    return None


def generate_colors_config(colors: JsonColors):
    _colors = []

    for i,color in enumerate(colors.colors):
        _colors.append("color{} {}".format(i, color))

    return _colors


def main():
    if len(sys.argv) < 2:
        print("The json file path argment is required")
        return 1
    
    json_path = sys.argv[1]
    json_colors = parse_json(json_path)
    
    if json_colors is None:
        print("Error opening or parsing {} file".format(json_path))
        return 2

    color_scheme = generate_colors_config(json_colors)

    print("background {}".format(json_colors.background))
    print("foreground {}".format(json_colors.foreground))
    print("\n".join(color_scheme))

    return 0


if __name__ == "__main__":
    main()
