--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


# 把所有.txt格式的子文件改为.vdf格式
prefix = '\"lang\"\n{\n\t\"Language\"\t\t\"%s\"\n\t\"Tokens\"\n\t{\n%s\n\t}\n}'
import os

dirs= os.listdir()
for dir in dirs:
    if os.path.isdir(dir):
        for dirpath, dirnames, filenames in os.walk("./" + dir):
            for filename in filenames:
                if filename.endswith(".txt"):
                    with open(os.path.join(dirpath, filename), "r", encoding="utf-8") as f:
                        content = f.read()
                        new_content = prefix % (dir, content)
                        with open(os.path.join(dirpath, filename), "w", encoding="utf-8") as f:
                            f.write(new_content)