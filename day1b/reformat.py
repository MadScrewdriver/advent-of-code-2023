k = {
    "one": 1,
    "two": 2,
    "three": 3,
    "four": 4,
    "five": 5,
    "six": 6,
    "seven": 7,
    "eight": 8,
    "nine": 9
}


def replace_first_word_with_digit(line):
    for char in range(len(line)):
        for word, digit in k.items():
            if line[char] in "123456789":
                return line
            if line[char:].startswith(word):
                return line.replace(word, str(digit), 1)
    return line


def replace_last_word_with_digit(line):
    for char in range(len(line)):
        for word, digit in k.items():
            if line[::-1][char:].startswith(word[::-1]):
                return line[::-1].replace(word[::-1], str(digit), 1)[::-1]
    return line


with open("input.txt", "r") as file:
    lines = [replace_last_word_with_digit(replace_first_word_with_digit(line.strip(" \n "))) for line in file]

with open("output.txt", "w") as file:
    file.writelines("\n".join(lines))