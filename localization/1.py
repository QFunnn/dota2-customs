--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]




import os

# for dirpath, dirnames, filenames in os.walk("."):
#     for filename in filenames:
#         if filename.endswith(".txt"):
#             os.rename(os.path.join(dirpath, filename), os.path.join(dirpath, filename.replace(".txt", ".vdf")))

dirs = os.listdir()
for dir in dirs:
    if os.path.isdir(dir):
        p = "./" + dir + "/heroes"
        ds = os.listdir(p)
        for d in ds:
            os.rename(os.path.join(p,d + "\\abilities.vdf"), os.path.join(p,d + "\\" + d+ ".vdf"))
