--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


import os
import re
from typing import Dict, Any

import vdf   # pip install vdf
import requests

RAW_ITEMS_TEXT: str = ""


def clean_kv_text(text: str) -> str:
    """
    Удаляем строки-комментарии (//, #), чтобы python-vdf не падал.
    """
    lines = []
    for line in text.splitlines():
        stripped = line.lstrip()
        if stripped.startswith("//") or stripped.startswith("#"):
            continue
        lines.append(line)
    return "\n".join(lines)


def load_keyvalues(path_or_url: str) -> Dict[str, Any]:
    """
    Загружаем items_game (локальный файл или URL) и сохраняем сырой текст в RAW_ITEMS_TEXT.
    Возвращаем распарсенный vdf-словарь.
    """
    global RAW_ITEMS_TEXT

    # URL
    if path_or_url.startswith("http://") or path_or_url.startswith("https://"):
        resp = requests.get(path_or_url)
        resp.raise_for_status()
        text = resp.text
    else:
        if not os.path.exists(path_or_url):
            raise FileNotFoundError(f"Файл не найден: {path_or_url}")
        with open(path_or_url, "r", encoding="utf-8") as f:
            text = f.read()

    RAW_ITEMS_TEXT = text

    cleaned = clean_kv_text(text)
    return vdf.loads(cleaned)


def build_item_blocks(text: str) -> Dict[str, str]:
    """
    Один проход по RAW_ITEMS_TEXT: собираем все блоки предметов в словарь {item_id: block}.

    Ищем конструкции вида:

        "12345"
        {
            ...
        }

    Считаем, что это именно item_def'ы из секции "items".
    """
    blocks: Dict[str, str] = {}

    # Регулярка ищет строку с "цифровым ключом" и сразу следующую строку со скобкой
    pattern = re.compile(
        r'^[ \t]*"(\d+)"[ \t]*\r?\n[ \t]*{',
        re.MULTILINE,
    )

    for m in pattern.finditer(text):
        item_id = m.group(1)
        brace_start = text.find("{", m.start())
        if brace_start == -1:
            continue

        depth = 0
        end = None
        for i in range(brace_start, len(text)):
            ch = text[i]
            if ch == "{":
                depth += 1
            elif ch == "}":
                depth -= 1
                if depth == 0:
                    end = i
                    break

        if end is None:
            continue

        block = text[brace_start:end + 1]
        blocks[item_id] = block

    return blocks


def extract_portraits_game_block(item_block: str) -> str | None:
    """
    Из блока предмета вытащить содержимое блока portraits -> game.

    В items_game это выглядит так:

        "portraits"
        {
            "game"
            {
                "PortraitLightPosition" "..."
                ...
            }
        }

    Возвращает текст ВНУТРИ фигурных скобок "game" { ... }, БЕЗ самих скобок.
    То есть голый список "Portrait..." и "cameras" и т.д.
    """
    # Находим portraits { ... }
    pos_portraits = item_block.find('"portraits"')
    if pos_portraits == -1:
        return None

    brace_start_portraits = item_block.find("{", pos_portraits)
    if brace_start_portraits == -1:
        return None

    depth = 0
    end_portraits = None
    for i in range(brace_start_portraits, len(item_block)):
        ch = item_block[i]
        if ch == "{":
            depth += 1
        elif ch == "}":
            depth -= 1
            if depth == 0:
                end_portraits = i
                break

    if end_portraits is None:
        return None

    portraits_block = item_block[brace_start_portraits:end_portraits + 1]

    # Внутри portraits ищем "game" { ... }
    pos_game = portraits_block.find('"game"')
    if pos_game == -1:
        return None

    brace_start_game = portraits_block.find("{", pos_game)
    if brace_start_game == -1:
        return None

    depth = 0
    end_game = None
    for i in range(brace_start_game, len(portraits_block)):
        ch = portraits_block[i]
        if ch == "{":
            depth += 1
        elif ch == "}":
            depth -= 1
            if depth == 0:
                end_game = i
                break

    if end_game is None:
        return None

    # Берём содержимое внутри фигурных скобок "game" { ... }
    inner = portraits_block[brace_start_game + 1:end_game]
    return inner.strip("\r\n")


def dump_portraits_game_for_items(
    items_kv_path_or_url: str,
    output_path: str,
):
    """
    Собирает ВСЕ портреты portraits -> game из items_game.txt в один KV-файл.

    На выходе формат:

        "33378"
        {
                "PortraitLightPosition" "..."
                ...
                "cameras"
                {
                        "default"
                        {
                                "PortraitPosition" "..."
                                ...
                        }
                }
        }

    Никакой лишней инфы: только ID предмета и содержимое portraits->game.
    """
    global RAW_ITEMS_TEXT

    print("Загружаю items_game...")
    all_items = load_keyvalues(items_kv_path_or_url)

    # Если структура вида { "items_game": { "items": {...} } }
    if "items_game" in all_items and isinstance(all_items["items_game"], dict):
        all_items = all_items["items_game"]

    items_dict = all_items.get("items", all_items)
    print("Всего предметов в items_game:", len(items_dict))

    # ВАЖНО: один раз построить карту item_id -> текстовый блок
    print("Строю индекс блоков предметов...")
    item_blocks = build_item_blocks(RAW_ITEMS_TEXT)
    print("Найдено текстовых блоков предметов:", len(item_blocks))

    written = 0

    with open(output_path, "w", encoding="utf-8") as f:
        for itemDef, item in items_dict.items():
            if not isinstance(item, dict):
                continue

            item_id_str = str(itemDef)
            item_block = item_blocks.get(item_id_str)
            if not item_block:
                continue

            # Достаём portraits -> game
            game_block_inner = extract_portraits_game_block(item_block)
            if not game_block_inner:
                continue

            # Пишем в KV-файл
            f.write(f'"{item_id_str}"\n')
            f.write("\t{\n")
            for line in game_block_inner.splitlines():
                if line.strip() == "":
                    continue
                # Делаем нормальные отступы (две табы внутри блока ID)
                f.write("\t\t" + line.rstrip() + "\n")
            f.write("\t}\n\n")

            written += 1

    print("====================================")
    print("Всего предметов с portraits->game:", written)
    print("Файл с портретами сохранён как:", output_path)


if __name__ == "__main__":
    # Путь к items_game.txt (как у тебя сейчас)
    ITEMS_PATH = "items_game.txt"
    OUTPUT_PATH = "item_portraits_game.txt"

    dump_portraits_game_for_items(
        items_kv_path_or_url=ITEMS_PATH,
        output_path=OUTPUT_PATH,
    )