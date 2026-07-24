--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


HeroBuilder.SealingAbilities = LoadKeyValues("scripts/npc/kv/gameplay/sealing_abilities.kv")

if PERCENTAGE_ABILITIES == nil then
    _G.PERCENTAGE_ABILITIES = LoadKeyValues("scripts/npc/kv/gameplay/no_spell_amp.txt") or {}
end

if DOT_ABILITIES == nil then
    _G.DOT_ABILITIES = LoadKeyValues("scripts/npc/kv/gameplay/torture_pipe.txt") or {}
end

if REFLECTION_ABILITIES == nil then
    _G.REFLECTION_ABILITIES = LoadKeyValues("scripts/npc/kv/gameplay/reflection_abilities.txt") or {}
end

if InnateAbilities == nil then
    _G.InnateAbilities = LoadKeyValues("scripts/npc/kv/gameplay/innate_abilities.kv") or {}
end