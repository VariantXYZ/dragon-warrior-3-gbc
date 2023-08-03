#!/bin/python
import os
import sys
import csv


PIXELS_PER_LINE = 18 * 8 # Max 18 characters x 8 pixel width
PIXELS_PER_RAMSTRING = 5 * 8 # Assume 5 characters for strings in RAM
CONTROL_CODE_NEWLINE = '<F1>'
CONTROL_CODE_WAIT = '<F7>'

def write_file(text_file):
    lines = []
    with open(text_file, 'r') as text:
        reader = csv.reader(text, delimiter=',', quotechar='"')
        header = next(reader, None)
        idx_index = header.index("Index")
        idx_text = header.index("Text")

        for line in reader:
            index = line[idx_index]
            txt = line[idx_text]

            if txt.startswith("@"):
                lines.append([index, txt])
                continue

            # Remove auto newlines
            txt = txt.replace(CONTROL_CODE_NEWLINE, ' ')
            l_space = get_symbol_len(' ') + 1
            
            # F7 is 'wait for input', which is an intentional pause
            blocks = txt.split(CONTROL_CODE_WAIT)
            new_blocks = []
            for b in blocks:
                words = b.split(' ')
                new_txt = words[0]
                new_len = get_word_len(words[0])

                for word in words[1:]:
                    l = get_word_len(word)
                    if l == 0: # Control code that isn't text
                        new_txt += word
                    elif new_len + l_space + l > PIXELS_PER_LINE:
                        new_txt += CONTROL_CODE_NEWLINE + word
                        new_len = l
                    elif new_len == 0:
                        new_txt += word
                        new_len = l
                    else:
                        new_txt += " " + word
                        new_len += l_space + l
                    if len(new_txt) > 4 and new_txt[-4] == '*':
                        new_txt += CONTROL_CODE_NEWLINE
                        new_len = 0

                new_blocks.append(new_txt.removesuffix(CONTROL_CODE_NEWLINE))
                
            lines.append([index, CONTROL_CODE_WAIT.join(new_blocks)])

    with open(text_file, 'w') as text:
        writer = csv.writer(text, delimiter=',', quotechar='"') 
        writer.writerow(['Index', 'Text'])
        for line in lines:
            writer.writerow(line)

def get_word_len(word):
    word_len = 0
    c = 0
    while c < len(word):
        sym = word[c]
        if sym == '<': # Preserve control codes as-is
            while c < len(word) and word[c] != '>':
                c += 1
                sym += word[c]
            if sym[1] == '&':
                word_len += PIXELS_PER_RAMSTRING + 1
            c += 1
            continue

        if sym == '[':
            while c < len(word) and word[c] != ']':
                c += 1
                sym += word[c]
        c += 1
        word_len += get_symbol_len(sym) + 1 # Symbol length + 1 for space between symbols
    return word_len

def get_symbol_len(s):
    return ({
        "0": 4,
        "1": 4,
        "2": 4,
        "3": 4,
        "4": 4,
        "5": 4,
        "6": 4,
        "7": 4,
        "8": 4,
        "9": 4,
        "A": 5,
        "B": 5,
        "C": 5,
        "D": 5,
        "E": 5,
        "F": 5,
        "G": 5,
        "H": 5,
        "I": 5,
        "J": 5,
        "K": 5,
        "L": 5,
        "M": 5,
        "N": 5,
        "O": 5,
        "P": 5,
        "Q": 5,
        "R": 5,
        "S": 5,
        "T": 5,
        "U": 5,
        "V": 5,
        "W": 5,
        "X": 5,
        "Y": 5,
        "Z": 5,
        "a": 5,
        "b": 4,
        "c": 4,
        "d": 4,
        "e": 4,
        "f": 4,
        "g": 4,
        "h": 4,
        "i": 1,
        "j": 2,
        "k": 4,
        "l": 1,
        "m": 5,
        "n": 4,
        "o": 4,
        "p": 4,
        "q": 4,
        "r": 4,
        "s": 4,
        "t": 4,
        "u": 4,
        "v": 4,
        "w": 5,
        "x": 4,
        "y": 4,
        "z": 4,
        "['s]": 6,
        "['m]": 7,
        "['r]": 6,
        "['t]": 6,
        "['v]": 6,
        "['l]": 3,
        "['d]": 6,
        "Ⅰ": 3,
        "Ⅱ": 5,
        "&": 5,
        "→": 7,
        "[*:]": 7,
        "𝟢": 7,
        "[Sword]": 8,
        "[Staff]": 8,
        "[Clothes]": 8,
        "[Helm]": 8,
        "[Knife]": 8,
        "[Sword2]": 8,
        "[Pole]": 8,
        "[Hammer]": 8,
        "[Armor]": 8,
        "[Shield]": 8,
        "[Ring]": 8,
        "[Claws]": 8,
        "[Abacus]": 8,
        "[Apron]": 8,
        "[Axe]": 8,
        "[Whip]": 8,
        "[Armor2]": 8,
        "[Swimsuit]": 8,
        "[Trunks]": 8,
        "[Hat]": 8,
        "[Tiara]": 8,
        "[Pendant]": 8,
        "[Book]": 8,
        "[Boomerang]": 8,
        "Ⅲ": 7,
        "•": 1,
        "*": 7,
        "「": 3,
        "」": 3,
        "?": 5,
        "!": 1,
        "…": 5,
        "‥": 3,
        "~": 7,
        "-": 4,
        "/": 4,
        "·": 1,
        ":": 1,
        "[Ex]": 7,
        "[Lv]": 7,
        "⎯": 8,
        "©": 7,
        "🞂": 4,
        "♂": 5,
        "♀": 5,
        "'": 1,
        ",": 2,
        ".": 1,
        ";": 2,
        "+": 5,
        "Ⅳ": 7,
        "\"": 7,
        " ": 2,
    })[s]

if __name__ == '__main__':
    # Arguments
    script_name = sys.argv[0]
    text_file = sys.argv[1]

    write_file(text_file)