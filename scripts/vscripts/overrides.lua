--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


CBaseEntity.SetAbsOrigin = CBaseEntity.SetOrigin

function RotatePosition(origin, angles, point)
	local p = point - origin
	local pitch = math.rad(angles.x)
	local yaw = math.rad(angles.y)
	local roll = math.rad(angles.z)

	-- yaw (Z-axis, most common)
	local cy, sy = math.cos(yaw), math.sin(yaw)
	local x1 = p.x * cy - p.y * sy
	local y1 = p.x * sy + p.y * cy
	local z1 = p.z

	-- pitch (Y-axis)
	local cp, sp = math.cos(pitch), math.sin(pitch)
	local x2 = x1 * cp + z1 * sp
	local y2 = y1
	local z2 = -x1 * sp + z1 * cp

	-- roll (X-axis)
	local cr, sr = math.cos(roll), math.sin(roll)
	local x3 = x2
	local y3 = y2 * cr - z2 * sr
	local z3 = y2 * sr + z2 * cr

	return origin + Vector(x3, y3, z3)
end

_G.MODIFIER_CACHE = _G.MODIFIER_CACHE or {}
_G.RADIUS_CACHE = _G.RADIUS_CACHE or {}
_G.CACHE_TIME = _G.CACHE_TIME or {}

if not CDOTA_BaseNPC.OldFindModifierByName then
	CDOTA_BaseNPC.OldFindModifierByName = CDOTA_BaseNPC.FindModifierByName
	function CDOTA_BaseNPC:FindModifierByName(name)
		local key = self:GetEntityIndex() .. "_" .. name
		local now = GameRules:GetGameTime()
		if not _G.MODIFIER_CACHE[key] or (now - (_G.CACHE_TIME[key] or 0)) > 0.1 or _G.MODIFIER_CACHE[key]:IsNull() then
			_G.MODIFIER_CACHE[key] = self:OldFindModifierByName(name)
			_G.CACHE_TIME[key] = now
		end
		return _G.MODIFIER_CACHE[key]
	end
end

_G.GLOBAL_RADIUS_CACHE = _G.GLOBAL_RADIUS_CACHE or {}
_G.GLOBAL_RADIUS_TIME = _G.GLOBAL_RADIUS_TIME or {}
local CACHE_DURATION = 0.03

if not _G.OldFindUnitsInRadius then
	_G.OldFindUnitsInRadius = _G.FindUnitsInRadius
end

_G.CACHE_STATS = { hits = 0, misses = 0 }

_G.FindUnitsInRadius = function(team, pos, cacheUnit, radius, tFilter, uFilter, fFilter, order, bCanEnt)
	-- Если аргументы битые, сразу в оригинал
	if type(team) ~= "number" or not pos then
		return _G.OldFindUnitsInRadius(team, pos, cacheUnit, radius, tFilter, uFilter, fFilter, order, bCanEnt)
	end

	-- Округляем позицию до 150 единиц.
	-- Все юниты в радиусе 150 кучки будут использовать один кэш.
	local gridX = math.floor(pos.x / 1500)
	local gridY = math.floor(pos.y / 1500)

	-- Ключ теперь общий для области, а не для конкретного юнита
	local cacheKey = string.format("grid_%d_%d_%d_%d_%d_%d", team, gridX, gridY, radius, tFilter, uFilter)

	local now = GameRules:GetGameTime()
	local cachedData = _G.GLOBAL_RADIUS_CACHE[cacheKey]
	local lastTime = _G.GLOBAL_RADIUS_TIME[cacheKey] or 0

	-- Увеличим время жизни до 0.1 сек (достаточно для одного кадра ИИ всех крипов)
	if cachedData and (now - lastTime) <= 0.1 then
		_G.CACHE_STATS.hits = _G.CACHE_STATS.hits + 1
		return cachedData
	end

	-- Реальный поиск
	_G.CACHE_STATS.misses = _G.CACHE_STATS.misses + 1
	local rawResults = _G.OldFindUnitsInRadius(team, pos, cacheUnit, radius, tFilter, uFilter, fFilter, order, bCanEnt)

	-- Фильтруем один раз
	local cleanTable = {}
	for i = 1, #rawResults do
		local u = rawResults[i]
		if u and not u:IsNull() then
			table.insert(cleanTable, u)
		end
	end

	_G.GLOBAL_RADIUS_CACHE[cacheKey] = cleanTable
	_G.GLOBAL_RADIUS_TIME[cacheKey] = now

	return cleanTable
end

Timers:CreateTimer(30, function()
	local hits = _G.CACHE_STATS.hits
	local misses = _G.CACHE_STATS.misses
	local total = hits + misses

	if total > 0 then
		local ratio = (hits / total) * 100
		print(string.format("[CACHE] +%d hits / +%d misses | %.1f%% | total saved: %d", hits, misses, ratio, hits))
	end

	-- сбрасываем и кэш и счётчики
	_G.GLOBAL_RADIUS_CACHE = {}
	_G.GLOBAL_RADIUS_TIME = {}
	_G.CACHE_STATS.hits = 0
	_G.CACHE_STATS.misses = 0

	return 20
end)