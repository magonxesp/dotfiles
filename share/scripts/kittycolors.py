import json
import sys


class JsonColors:

    def __init__(self, colors: dict):
        self.colors = colors["color"]
        self.background = colors["background"]
        self.foreground = colors["foreground"]

    def to_kitty_conf(self):
        color_scheme_comments = [
            'black',
            'red',
            'green',
            'yellow',
            'blue',
            'magenta',
            'cyan',
            'white'
        ]

        conf = "# Color Scheme\n\n"

        conf += "background {}\n".format(self.background)
        conf += "foreground {}\n\n".format(self.foreground)

        colors_len = int(len(self.colors) / 2)

        i = 0
        j = colors_len

        while i < colors_len:
            conf += "color{} {}\n".format(i, self.colors[i])
            conf += "color{} {}\n".format(j, self.colors[j])
            conf += "#: {}\n\n".format(color_scheme_comments[i])

            i += 1
            j = i + colors_len

        return conf


def parse_json(path: str):
    colors = {}

    with open(path, "r") as file:
        colors = json.loads(file.read())

    if "color" in colors:
        return JsonColors(colors)

    return None


def main():
    if len(sys.argv) < 2:
        raise Exception("The json file path argment is required")
    
    json_path = sys.argv[1]
    json_colors = parse_json(json_path)
    
    if json_colors is None:
        raise Exception("Error opening or parsing {} file".format(json_path))

    print(json_colors.to_kitty_conf())


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(str(e))
        exit(1)
