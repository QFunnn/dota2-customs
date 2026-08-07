--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/kv"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringSplit
local f = b.__TS__DecorateLegacy
local g = b.__TS__New
local h = {}
local i = require("lib.tstl-utils")
local j = i.reloadable
local k = c()
k.name = "MKeyValues"
d(k, CModule)
function k.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.abilities = LoadKeyValues("scripts/npc/npc_abilities_custom.txt")
	self.units = LoadKeyValues("scripts/npc/npc_units_custom.txt")
	self.heroes = LoadKeyValues("scripts/npc/npc_heroes_custom.txt")
	self.hero_abilities = LoadKeyValues("scripts/npc/abilities/hero_abilities.kv")
	self.items = LoadKeyValues("scripts/npc/npc_items_custom.txt")
	self.spawn_info = LoadKeyValues("scripts/npc/gameplay/spawn_info.kv")
	self.spawn_info_jungle = LoadKeyValues("scripts/npc/gameplay/spawn_info_jungle.kv")
	self.spawn_info_lava = LoadKeyValues("scripts/npc/gameplay/spawn_info_lava.kv")
	self.spawn_info_sand = LoadKeyValues("scripts/npc/gameplay/spawn_info_sand.kv")
	self.spawn_info_ice = LoadKeyValues("scripts/npc/gameplay/spawn_info_ice.kv")
	self.difficulty = LoadKeyValues("scripts/npc/gameplay/difficulty.kv")
	self.abyss_spawn = LoadKeyValues("scripts/npc/gameplay/abyssal_spawn.kv")
	self.abyss_difficulty = LoadKeyValues("scripts/npc/gameplay/abyssal_difficulty.kv")
	self.battle_gem_levels = LoadKeyValues("scripts/npc/gameplay/battle_gem_levels.kv")
	self.battle_gem_difficulty = LoadKeyValues("scripts/npc/service/gem_diff.kv")
	self.abyss_drop = LoadKeyValues("scripts/npc/gameplay/abyssal_drop.kv")
	self.abyss_dropItems = LoadKeyValues("scripts/npc/gameplay/abyssal_drop_items.kv")
	self.abyss_events = LoadKeyValues("scripts/npc/gameplay/abyssal_events.kv")
	self.artifact = LoadKeyValues("scripts/npc/items/artifact.kv")
	self.info_item_equipment = LoadKeyValues("scripts/npc/service/info_item_equipment.kv")
	self.info_item_key = LoadKeyValues("scripts/npc/service/info_item_key.kv")
	self.key_diff_setting = LoadKeyValues("scripts/npc/service/key_diff_setting.kv")
	self.collection_treasure = LoadKeyValues("scripts/npc/gameplay/collection_treasure.kv")
	self.idle_game_setting = LoadKeyValues("scripts/npc/service/idle_game_setting.kv")
	self.equip_class_setting = LoadKeyValues("scripts/npc/service/equip_class_setting.kv")
	self.fish_consume = LoadKeyValues("scripts/npc/service/fish_consume.kv")
end
function k.prototype.initPriority(self)
	return 3
end
function k.prototype.init(self, l)
	self.abilities = LoadKeyValues("scripts/npc/npc_abilities_custom.txt")
	self.units = LoadKeyValues("scripts/npc/npc_units_custom.txt")
	self.heroes = LoadKeyValues("scripts/npc/npc_heroes_custom.txt")
	self.hero_abilities = LoadKeyValues("scripts/npc/abilities/hero_abilities.kv")
	self.items = LoadKeyValues("scripts/npc/npc_items_custom.txt")
	self.spawn_info = LoadKeyValues("scripts/npc/gameplay/spawn_info.kv")
	self.spawn_info_jungle = LoadKeyValues("scripts/npc/gameplay/spawn_info_jungle.kv")
	self.spawn_info_lava = LoadKeyValues("scripts/npc/gameplay/spawn_info_lava.kv")
	self.spawn_info_sand = LoadKeyValues("scripts/npc/gameplay/spawn_info_sand.kv")
	self.spawn_info_ice = LoadKeyValues("scripts/npc/gameplay/spawn_info_ice.kv")
	self.difficulty = LoadKeyValues("scripts/npc/gameplay/difficulty.kv")
	self.battle_gem_levels = LoadKeyValues("scripts/npc/gameplay/battle_gem_levels.kv")
	self.battle_gem_difficulty = LoadKeyValues("scripts/npc/service/gem_diff.kv")
	self.privilegeKv = LoadKeyValues("scripts/npc/abilities/privilege.kv")
	self.weapon = LoadKeyValues("scripts/npc/service/weapon.kv")
	self.soul_infusions = LoadKeyValues("scripts/npc/service/hero_soul_infusion_effect.kv")
	self.weapon_asset_modifier = LoadKeyValues("scripts/npc/weapon_asset_modifier.txt")
	self.bp_season = LoadKeyValues("scripts/npc/service/bp_season.kv")
	self.bless_set_bonus = LoadKeyValues("scripts/npc/items/bless_set_bonus.kv")
	self.idle_game_fish_type = LoadKeyValues("scripts/npc/service/idle_game_fish_type.kv")
	self.artifact = LoadKeyValues("scripts/npc/items/artifact.kv")
	self.info_item_key = LoadKeyValues("scripts/npc/service/info_item_key.kv")
	self.key_diff_setting = LoadKeyValues("scripts/npc/service/key_diff_setting.kv")
	self.info_item_rarity = LoadKeyValues("scripts/npc/service/info_item_rarity.kv")
	self.settle_setting = LoadKeyValues("scripts/npc/service/settle_setting.kv")
	self.service_courier = LoadKeyValues("scripts/npc/service/service_courier.kv")
	self.explore_reward = LoadKeyValues("scripts/npc/service/explore_reward.kv")
	self.explore_slot = LoadKeyValues("scripts/npc/service/explore_slot.kv")
	self.task = LoadKeyValues("scripts/npc/service/task.kv")
	self.collection = LoadKeyValues("scripts/npc/service/collection.kv")
	self.fish_rods = LoadKeyValues("scripts/npc/service/idle_game_fish_rod.kv")
	self.game_setting = self:ParseGameSetting(LoadKeyValues("scripts/npc/service/game_setting.kv"))
	self.info_item_cosmetic = LoadKeyValues("scripts/npc/service/info_item_cosmetic.kv")
	self.keys = LoadKeyValues("scripts/npc/items/keys.kv")
	self.courier = LoadKeyValues("scripts/npc/service/courier.kv")
	self:print("[KeyValues] KeyValues 加载完成", IsServer())
	if IsClient() then
		self.portrait_full_body_loadout = TableOverride(
			LoadKeyValues("scripts/npc/portraits_full_body_loadout.txt"),
			LoadKeyValues("scripts/npc/portraits_full_body_loadout_custom.txt")
		)
		self.portraits_weapon = LoadKeyValues("scripts/npc/portraits_weapon.txt")
		self.portraits_pod = LoadKeyValues("scripts/npc/portraits_pod.txt")
		self.portraits_fish = LoadKeyValues("scripts/npc/portraits_fish.txt")
	end
end
function k.prototype.ParseGameSetting(self, m)
	local n = tostring
	local o = m.revive_cost
	local p = e(n(o and o.value or "0:0"), ":")
	local q = tostring
	local r = m.in_game_bless_refresh_cost
	local s = e(q(r and r.value or "0:0"), ":")
	local t = tostring
	local u = m.in_game_ability_upgrade_cost
	local v = e(t(u and u.value or "0:0"), ":")
	local w = {}
	local x = tostring
	local y = m.adventure_lock
	local z = e(x(y and y.value or ""), "|")
	do
		local A = 0
		while A < #z do
			local B = z[A + 1]
			if B ~= "" then
				w[B] = true
			end
			A = A + 1
		end
	end
	local C = toFiniteNumber(p[1], 0)
	local D = toFiniteNumber(p[2], 0)
	local E = toFiniteNumber
	local F = m.revive_max
	local G = { itemId = C, itemCount = D, max = E(F and F.value, 0) }
	local H = toFiniteNumber(s[1], 0)
	local I = toFiniteNumber(s[2], 0)
	local J = toFiniteNumber
	local K = m.in_game_bless_refresh_max
	local L = { itemId = H, itemCount = I, max = J(K and K.value, 3) }
	local M = toFiniteNumber(v[1], 0)
	local N = toFiniteNumber(v[2], 0)
	local O = toFiniteNumber
	local P = m.in_game_ability_upgrade_max
	return {
		revive = G,
		in_game_bless_refresh = L,
		in_game_ability_upgrade = { itemId = M, itemCount = N, max = O(P and P.value, 3) },
		adventureLocks = w,
	}
end
function k.prototype.GetUnitData(self, Q, ...)
	local R
	if type(Q) == "number" then
		Q = EntIndexToHScript(Q)
	end
	local m
	if type(Q) == "table" and IsValid(Q) then
		R = Q:GetUnitName()
		m = self.heroes[R] or self.units[R]
	elseif type(Q) == "string" then
		m = self.heroes[Q] or self.units[Q]
	end
	if m == nil then
		return nil
	end
	local S = {}
	local T = select("#", ...)
	for A = 1, T, 1 do
		local U = select(A, ...)
		S[A] = m[U]
	end
	return unpack(S, 1, T)
end
function k.prototype.GetAttackSoundSet(self, V, W)
	local X = KeyValues:GetUnitData(V, "SoundSet")
	if type(X) == "string" and X ~= "" then
		return X
	end
	return ""
end
function k.prototype.GetKvAbilityValue(self, m, Y, U, Z, _)
	if Z == nil then
		Z = 1
	end
	local a0 = m[Y]
	if a0 ~= nil then
		a0 = a0.AbilityValues
	end
	local a1 = a0
	if a1 == nil then
		return 0
	end
	return GetAbilityValues(a1[U], Z, _)
end
k = f({ j }, k)
if KeyValues == nil then
	KeyValues = g(k)
end
return h