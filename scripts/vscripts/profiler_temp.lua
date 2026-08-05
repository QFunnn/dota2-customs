--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


-- =====================================================================
-- ВРЕМЕННЫЙ ДИАГНОСТИЧЕСКИЙ ПРОФАЙЛЕР ПРОИЗВОДИТЕЛЬНОСТИ
-- Считает, сколько раз за окно (10с) вызываются дорогие операции,
-- сгруппированно по месту вызова (файл:строка), и печатает топ.
-- Помогает найти настоящий хот-пат вместо угадывания.
-- Включается только в tools-режиме. После диагностики файл удалить
-- и убрать require("profiler_temp") из addon_game_mode.lua.
-- =====================================================================

if not IsInToolsMode() then
	return
end

_G.PROF = _G.PROF or { sites = {}, funcs = {} }

local function record(funcName)
	local site = "?"
	if debug and debug.getinfo then
		-- [1]=record, [2]=обёртка, [3]=реальный вызыватель
		local info = debug.getinfo(3, "Sl")
		if info then
			site = (info.short_src or "?") .. ":" .. tostring(info.currentline)
		end
	end

	local key = funcName .. "  <- " .. site
	_G.PROF.sites[key] = (_G.PROF.sites[key] or 0) + 1
	_G.PROF.funcs[funcName] = (_G.PROF.funcs[funcName] or 0) + 1
end

-- обернуть глобальную функцию (_G[name])
local function wrapGlobal(name)
	local orig = _G[name]
	if type(orig) ~= "function" then
		return
	end
	_G[name] = function(...)
		record(name)
		return orig(...)
	end
end

-- обернуть метод класса
local function wrapMethod(class, name, label)
	if not class or type(class[name]) ~= "function" then
		return
	end
	local orig = class[name]
	class[name] = function(self, ...)
		record(label)
		return orig(self, ...)
	end
end

wrapGlobal("FindUnitsInRadius")
wrapGlobal("ApplyDamage")

wrapMethod(CDOTA_BaseNPC, "PerformAttack", "PerformAttack")
wrapMethod(CDOTA_BaseNPC, "AddNewModifier", "AddNewModifier")
wrapMethod(CDOTA_BaseNPC, "CalculateStatBonus", "CalculateStatBonus")
wrapMethod(ParticleManager, "CreateParticle", "CreateParticle")

Timers:CreateTimer(10, function()
	local arr = {}
	for k, v in pairs(_G.PROF.sites) do
		arr[#arr + 1] = { k, v }
	end
	table.sort(arr, function(a, b)
		return a[2] > b[2]
	end)

	print("============ [PROF] ТОП мест вызова за 10с ============")
	for i = 1, math.min(15, #arr) do
		print(string.format("[PROF] %7d  %s", arr[i][2], arr[i][1]))
	end

	print("------------ [PROF] итого по функциям ------------")
	local farr = {}
	for k, v in pairs(_G.PROF.funcs) do
		farr[#farr + 1] = { k, v }
	end
	table.sort(farr, function(a, b)
		return a[2] > b[2]
	end)
	for i = 1, #farr do
		print(string.format("[PROF] %7d  %s", farr[i][2], farr[i][1]))
	end
	print("======================================================")

	_G.PROF.sites = {}
	_G.PROF.funcs = {}
	return 10
end)

print("[PROF] performance profiler enabled")