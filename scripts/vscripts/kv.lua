--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "kv"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayFilter
local f = b.__TS__ArrayForEach
local g = b.__TS__DecorateLegacy
local h = b.__TS__New
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 1,
		["12"] = 1,
		["13"] = 5,
		["14"] = 12,
		["15"] = 12,
		["16"] = 13,
		["18"] = 13,
		["19"] = 143,
		["20"] = 141,
		["21"] = 59,
		["22"] = 60,
		["23"] = 61,
		["24"] = 62,
		["25"] = 63,
		["26"] = 64,
		["27"] = 65,
		["28"] = 66,
		["29"] = 66,
		["30"] = 66,
		["31"] = 66,
		["32"] = 66,
		["33"] = 66,
		["34"] = 66,
		["35"] = 67,
		["36"] = 68,
		["37"] = 69,
		["38"] = 70,
		["40"] = 73,
		["41"] = 74,
		["42"] = 75,
		["43"] = 76,
		["44"] = 77,
		["45"] = 78,
		["46"] = 79,
		["47"] = 79,
		["48"] = 79,
		["49"] = 79,
		["50"] = 80,
		["51"] = 81,
		["52"] = 82,
		["53"] = 83,
		["54"] = 84,
		["55"] = 85,
		["56"] = 86,
		["59"] = 89,
		["60"] = 90,
		["61"] = 91,
		["62"] = 92,
		["63"] = 93,
		["64"] = 93,
		["66"] = 95,
		["67"] = 95,
		["68"] = 96,
		["69"] = 97,
		["70"] = 98,
		["71"] = 99,
		["72"] = 100,
		["73"] = 101,
		["74"] = 102,
		["75"] = 103,
		["76"] = 104,
		["77"] = 105,
		["78"] = 106,
		["79"] = 108,
		["80"] = 109,
		["81"] = 110,
		["82"] = 110,
		["83"] = 110,
		["84"] = 110,
		["85"] = 111,
		["86"] = 112,
		["87"] = 113,
		["89"] = 114,
		["90"] = 114,
		["91"] = 115,
		["92"] = 116,
		["93"] = 117,
		["94"] = 118,
		["96"] = 114,
		["101"] = 123,
		["102"] = 124,
		["104"] = 125,
		["105"] = 125,
		["106"] = 126,
		["107"] = 127,
		["108"] = 128,
		["109"] = 129,
		["111"] = 125,
		["116"] = 135,
		["117"] = 137,
		["118"] = 59,
		["119"] = 145,
		["120"] = 146,
		["121"] = 147,
		["123"] = 149,
		["124"] = 149,
		["125"] = 151,
		["126"] = 152,
		["127"] = 152,
		["128"] = 152,
		["129"] = 152,
		["130"] = 153,
		["131"] = 154,
		["133"] = 156,
		["135"] = 149,
		["136"] = 149,
		["137"] = 149,
		["138"] = 145,
		["139"] = 163,
		["140"] = 164,
		["141"] = 164,
		["142"] = 164,
		["143"] = 164,
		["144"] = 165,
		["145"] = 166,
		["146"] = 167,
		["147"] = 167,
		["148"] = 167,
		["149"] = 168,
		["150"] = 167,
		["151"] = 167,
		["153"] = 163,
		["154"] = 173,
		["155"] = 174,
		["156"] = 175,
		["157"] = 176,
		["159"] = 178,
		["160"] = 179,
		["161"] = 180,
		["162"] = 181,
		["165"] = 184,
		["166"] = 185,
		["167"] = 186,
		["168"] = 186,
		["169"] = 186,
		["170"] = 186,
		["171"] = 187,
		["172"] = 188,
		["173"] = 189,
		["174"] = 190,
		["179"] = 195,
		["180"] = 196,
		["181"] = 196,
		["182"] = 196,
		["184"] = 196,
		["186"] = 196,
		["188"] = 197,
		["189"] = 197,
		["191"] = 197,
		["192"] = 198,
		["193"] = 199,
		["194"] = 200,
		["195"] = 200,
		["196"] = 200,
		["198"] = 200,
		["200"] = 201,
		["201"] = 201,
		["203"] = 201,
		["205"] = 173,
		["206"] = 12,
		["207"] = 209,
		["208"] = 210,
	}
)
local j = {}
local k = require("lib.tstl-utils")
local l = k.reloadable
_G.SYNC_UNIT_KEY = { "AttackDamage" }
local m = c()
m.name = "CKeyValues"
d(m, CModule)
function m.prototype.____constructor(self)
	CModule.prototype.____constructor(self)
	self:InitKVs()
end
function m.prototype.InitKVs(self)
	self.ReservoirsKv = LoadKeyValues("scripts/npc/kv/reservoirs.kv")
	self.PoolsKv = LoadKeyValues("scripts/npc/kv/pools.kv")
	self.HerolistKv = LoadKeyValues("scripts/npc/herolist.txt")
	self.UnitsKv = LoadKeyValues("scripts/npc/npc_units_custom.txt")
	self.AbilitiesKv = LoadKeyValues("scripts/npc/npc_abilities_custom.txt")
	self.ConsumablesKv = LoadKeyValues("scripts/npc/kv/abilities/consumables.kv")
	self.ItemsKv = TableReplace(
		TableOverride(LoadKeyValues("scripts/npc/items.txt"), LoadKeyValues("scripts/npc/npc_items_custom.txt")),
		LoadKeyValues("scripts/npc/npc_abilities_override.txt")
	)
	self.ItemsGame = {}
	self.HeroesKv = {}
	for n in pairs(self.HerolistKv) do
		self.HeroesKv[n] = DOTAGameManager:GetHeroDataByName_Script(n)
	end
	self.RoundKvs = LoadKeyValues("scripts/npc/kv/gameplay/round.kv")
	self.SpawnerGroupKvs = LoadKeyValues("scripts/npc/kv/gameplay/spawner_group.kv")
	self.AbilityUpgradesKvs = LoadKeyValues("scripts/npc/kv/abilities/ability_upgrades.kv")
	self.AbilityUpgradesMechenicsKV = LoadKeyValues("scripts/npc/kv/abilities/ability_upgrades_mechenics.kv")
	self.ArtifactKvs = LoadKeyValues("scripts/npc/kv/abilities/items.kv")
	self.CommonUnitsKv = LoadKeyValues("scripts/npc/kv/units/npc_common.kv")
	self.NpcHeroesKv = TableOverride(
		LoadKeyValues("scripts/npc/kv/units/npc_heroes.kv"),
		LoadKeyValues("scripts/npc/npc_heroes_custom.txt")
	)
	self.GreevilEggKv = LoadKeyValues("scripts/npc/kv/abilities/greevil_egg.kv")
	self.GreevilAbilityKV = LoadKeyValues("scripts/npc/kv/abilities/greevil_ability.kv")
	self.GreevilShopKV = LoadKeyValues("scripts/npc/kv/gameplay/greevil_shop.kv")
	self.HeroIDCache = {}
	for o, p in pairs(self.CommonUnitsKv) do
		if p.Hid then
			self.HeroIDCache[p.Hid] = o
		end
	end
	self.NewPlayerUnitsKv = LoadKeyValues("scripts/npc/kv/units/npc_new_player.kv")
	self.SectAbilitiesKv = LoadKeyValues("scripts/npc/kv/abilities/sect_abilities.kv")
	self.SectList = {}
	for q, r in pairs(self.SectAbilitiesKv) do
		local s = self.SectList
		s[#s + 1] = q
	end
	local t = self.SectList
	t[#t + 1] = "sect_none"
	self.SectBannedNewPlayerKv = LoadKeyValues("scripts/npc/kv/abilities/sect_banned_new_player.kv")
	self.HeroTalentKv = LoadKeyValues("scripts/npc/kv/abilities/hero_talent.kv")
	self.NeutralUnitsKv = LoadKeyValues("scripts/npc/kv/units/npc_neutral.kv")
	self.CustomAbilitiesKv = LoadKeyValues("scripts/npc/kv/abilities/custom_ability.kv")
	self.TraitAbilitiesKv = LoadKeyValues("scripts/npc/kv/abilities/trait_abilities.kv")
	self.CityEffectKV = LoadKeyValues("scripts/npc/kv/abilities/city_effect.kv")
	self.CardEffectKV = LoadKeyValues("scripts/npc/kv/abilities/card_effect.kv")
	self.GreevilEffectKV = LoadKeyValues("scripts/npc/kv/abilities/greevil_effect.kv")
	self.CosmeticsKV = LoadKeyValues("scripts/npc/kv/gameplay/cosmetics.kv")
	self.RuneTaskKV = LoadKeyValues("scripts/npc/kv/gameplay/rune_task.kv")
	self.HeroShardKV = LoadKeyValues("scripts/npc/kv/abilities/hero_shard.kv")
	self.Portrait = LoadKeyValues("scripts/npc/portraits.txt")
	self.PortraitCustom = LoadKeyValues("scripts/npc/portraits_custom.txt")
	self.PortraitFullBody = TableOverride(
		LoadKeyValues("scripts/npc/portraits_full_body.txt"),
		LoadKeyValues("scripts/npc/portraits_full_body_custom.txt")
	)
	local u = LoadKeyValues("scripts/npc/items_game.kv")
	for v, w in pairs(self.UnitsKv) do
		if type(w) == "table" then
			do
				local x = 1
				while x <= 10 do
					local y = tostring(w["wearable" .. tostring(x)])
					local z = u[y]
					if z ~= nil then
						self.ItemsGame[y] = z
					end
					x = x + 1
				end
			end
		end
	end
	for v, w in pairs(self.CosmeticsKV) do
		if type(w) == "table" then
			do
				local x = 1
				while x <= 10 do
					local y = tostring(w["wearable" .. tostring(x)])
					local z = u[y]
					if z ~= nil then
						self.ItemsGame[y] = z
					end
					x = x + 1
				end
			end
		end
	end
	self.EquipmentKv = LoadKeyValues("scripts/npc/kv/abilities/equipments.kv")
	self.NewMarkInfoKv = LoadKeyValues("scripts/npc/kv/gameplay/new_mark_info.kv")
end
function m.prototype.init(self, A)
	if A then
		self:InitKVs()
	end
	GameEvent("custom_game_start", function()
		print("custom_game_start", IsServer())
		if IsGroupMode(nil) then
			self.CardEffectKV = LoadKeyValues("scripts/npc/kv/abilities/team_card.kv")
		else
			self.CardEffectKV = LoadKeyValues("scripts/npc/kv/abilities/card_effect.kv")
		end
	end, self)
end
function m.prototype.AddWearableToItemsGame(self, B)
	B = e(B, function(C, D)
		return self.ItemsGame[D] == nil
	end)
	if #B > 0 then
		local E = LoadKeyValues("scripts/npc/items_game.kv")
		f(B, function(C, D)
			self.ItemsGame[D] = E[D]
		end)
	end
end
function m.prototype.GetUnitData(self, F, G)
	local H
	if type(F) == "number" then
		F = EntIndexToHScript(F)
	end
	if type(F) == "table" and IsValid(F) then
		if IsServer() then
			if type(F._tOverrideData) == "table" and F._tOverrideData[G] ~= nil then
				return F._tOverrideData[G]
			end
		else
			local I = TableFindKey(SYNC_UNIT_KEY, G)
			if I ~= nil then
				local J = CustomNetTables:GetTableValue("unit_kv", tostring(F:entindex()))
				if J ~= nil then
					local K = json.decode(J._)
					if K ~= nil then
						return K[I]
					end
				end
			end
		end
		H = F:GetUnitName()
		local L
		if F:IsHero() then
			L = self.HeroesKv[H]
		else
			L = self.UnitsKv[H]
		end
		local z = L
		local M
		if z ~= nil then
			M = z[G]
		end
		return M
	elseif type(F) == "string" then
		H = F
		local N = self.HeroesKv[H]
		if N == nil then
			N = self.UnitsKv[H]
		end
		local z = N
		local O
		if z ~= nil then
			O = z[G]
		end
		return O
	end
end
m = g({ l }, m)
if _G.KeyValues == nil then
	_G.KeyValues = h(m)
end
return j