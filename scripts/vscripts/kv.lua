--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if KeyValues == nil then
	KeyValues = class({})
end

if IsServer() then
	-- KeyValues.ReservoirsKv = LoadKeyValues("scripts/npc/kv/reservoirs.kv")
	-- KeyValues.PoolsKv = LoadKeyValues("scripts/npc/kv/pools.kv")

	-- KeyValues.HerolistKv = LoadKeyValues("scripts/npc/herolist.txt")
	KeyValues.UnitsKv = LoadKeyValues("scripts/npc/npc_units_custom.txt")
	-- KeyValues.AbilitiesKv = LoadKeyValues("scripts/npc/npc_abilities_custom.txt")
	-- KeyValues.ItemsKv = TableReplace(TableOverride(LoadKeyValues("scripts/npc/items.txt"), LoadKeyValues("scripts/npc/npc_items_custom.txt")), LoadKeyValues("scripts/npc/npc_abilities_override.txt"))
	-- KeyValues.HeroesKv = {}
else
	-- KeyValues.AbilitiesKv = LoadKeyValues("scripts/npc/npc_abilities_custom.txt")
	-- KeyValues.ItemsKv = TableReplace(TableOverride(LoadKeyValues("scripts/npc/items.txt"), LoadKeyValues("scripts/npc/npc_items_custom.txt")), LoadKeyValues("scripts/npc/npc_abilities_override.txt"))
	-- KeyValues.HerolistKv = LoadKeyValues("scripts/npc/herolist.txt")
	-- KeyValues.HeroesKv = {}
	-- for sHeroName, _ in pairs(KeyValues.HerolistKv) do
	-- 	KeyValues.HeroesKv[sHeroName] = DOTAGameManager:GetHeroDataByName_Script(sHeroName)
	-- end
	-- KeyValues.UnitsKv = LoadKeyValues("scripts/npc/npc_units_custom.txt")
	KeyValues.PortraitFullBodyLoadout = TableOverride(LoadKeyValues("scripts/npc/portraits_full_body_loadout.txt"), LoadKeyValues("scripts/npc/portraits_full_body_loadout_custom.txt"))
	KeyValues.HeroSkinKV = LoadKeyValues("scripts/npc/kv/gameplay/info_hero_skin.kv")
end


---@param default any @默认值，如果索引到空值则会返回默认值
---@param ... string @名字，不定参数，全部为string类，按名字顺序分别索引
---@vararg string
---@return any @返回索引出的值或者默认值
function GetKV(default, ...)
	local temp = KeyValues
	for i, v in ipairs { ... } do
		if temp[v] == nil then
			return default
		end
		temp = temp[v]
	end
	return temp
end

_G.SYNC_UNIT_KEY = {
	"AttackDamage",
	"AttackRate",
	"Armor",
	"CustomStatusHealth",
	"DamageReduction",
}

---@param unit string | number | CDOTA_BaseNPC 单位，实体、实体index或者单位名字
---@param key string 键值名字
---@return nil | any 成功则会返回非nil值
function KeyValues:GetUnitData(unit, key)
	local sUnitName
	if type(unit) == "number" then
		unit = EntIndexToHScript(unit)
	end
	if type(unit) == "table" and IsValid(unit) then
		if IsServer() then
			if type(unit._tOverrideData) == "table" and unit._tOverrideData[key] ~= nil then
				return unit._tOverrideData[key]
			end
		else
			local index = TableFindKey(SYNC_UNIT_KEY, key)
			if index ~= nil then
				local nettable = CustomNetTables:GetTableValue("unit_kv", tostring(unit:entindex()))
				if nettable then
					local tOverrideKV = json.decode(nettable._)
					if tOverrideKV then
						return tOverrideKV[index]
					end
				end
			end
		end
		sUnitName = unit:GetUnitName()
		local tData = unit:IsHero() and KeyValues.HeroesKv[sUnitName] or KeyValues.UnitsKv[sUnitName]
		return tData and tData[key] or nil
	elseif type(unit) == "string" then
		sUnitName = unit
		local tData = KeyValues.HeroesKv[sUnitName] or KeyValues.UnitsKv[sUnitName]
		return tData and tData[key] or nil
	end
end