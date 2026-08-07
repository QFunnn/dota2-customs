--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
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
		["19"] = 147,
		["20"] = 145,
		["21"] = 61,
		["22"] = 62,
		["23"] = 63,
		["24"] = 64,
		["25"] = 65,
		["26"] = 66,
		["27"] = 67,
		["28"] = 68,
		["29"] = 68,
		["30"] = 68,
		["31"] = 68,
		["32"] = 68,
		["33"] = 68,
		["34"] = 68,
		["35"] = 69,
		["36"] = 70,
		["37"] = 71,
		["38"] = 72,
		["40"] = 75,
		["41"] = 76,
		["42"] = 77,
		["43"] = 78,
		["44"] = 79,
		["45"] = 80,
		["46"] = 81,
		["47"] = 81,
		["48"] = 81,
		["49"] = 81,
		["50"] = 82,
		["51"] = 83,
		["52"] = 84,
		["53"] = 85,
		["54"] = 86,
		["55"] = 87,
		["56"] = 88,
		["57"] = 89,
		["58"] = 90,
		["61"] = 93,
		["62"] = 94,
		["63"] = 95,
		["64"] = 96,
		["65"] = 97,
		["66"] = 97,
		["68"] = 99,
		["69"] = 99,
		["70"] = 100,
		["71"] = 101,
		["72"] = 102,
		["73"] = 103,
		["74"] = 104,
		["75"] = 105,
		["76"] = 106,
		["77"] = 107,
		["78"] = 108,
		["79"] = 109,
		["80"] = 110,
		["81"] = 112,
		["82"] = 113,
		["83"] = 114,
		["84"] = 114,
		["85"] = 114,
		["86"] = 114,
		["87"] = 115,
		["88"] = 116,
		["89"] = 117,
		["91"] = 118,
		["92"] = 118,
		["93"] = 119,
		["94"] = 120,
		["95"] = 121,
		["96"] = 122,
		["98"] = 118,
		["103"] = 127,
		["104"] = 128,
		["106"] = 129,
		["107"] = 129,
		["108"] = 130,
		["109"] = 131,
		["110"] = 132,
		["111"] = 133,
		["113"] = 129,
		["118"] = 139,
		["119"] = 141,
		["120"] = 61,
		["121"] = 149,
		["122"] = 150,
		["123"] = 151,
		["125"] = 153,
		["126"] = 153,
		["127"] = 155,
		["128"] = 156,
		["129"] = 156,
		["130"] = 156,
		["131"] = 156,
		["132"] = 157,
		["133"] = 158,
		["135"] = 160,
		["137"] = 153,
		["138"] = 153,
		["139"] = 153,
		["140"] = 149,
		["141"] = 167,
		["142"] = 168,
		["143"] = 168,
		["144"] = 168,
		["145"] = 168,
		["146"] = 169,
		["147"] = 170,
		["148"] = 171,
		["149"] = 171,
		["150"] = 171,
		["151"] = 172,
		["152"] = 171,
		["153"] = 171,
		["155"] = 167,
		["156"] = 177,
		["157"] = 178,
		["158"] = 179,
		["159"] = 180,
		["161"] = 182,
		["162"] = 183,
		["163"] = 184,
		["164"] = 185,
		["167"] = 188,
		["168"] = 189,
		["169"] = 190,
		["170"] = 190,
		["171"] = 190,
		["172"] = 190,
		["173"] = 191,
		["174"] = 192,
		["175"] = 193,
		["176"] = 194,
		["181"] = 199,
		["182"] = 200,
		["183"] = 200,
		["184"] = 200,
		["186"] = 200,
		["188"] = 200,
		["190"] = 201,
		["191"] = 201,
		["193"] = 201,
		["194"] = 202,
		["195"] = 203,
		["196"] = 204,
		["197"] = 204,
		["198"] = 204,
		["200"] = 204,
		["202"] = 205,
		["203"] = 205,
		["205"] = 205,
		["207"] = 177,
		["208"] = 12,
		["209"] = 213,
		["210"] = 214,
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
	self.treasure_abilities = LoadKeyValues("scripts/npc/kv/abilities/treasure_abilities.kv")
	self.GreevilShopKV = LoadKeyValues("scripts/npc/kv/gameplay/greevil_shop.kv")
	self.TreasureShopKV = LoadKeyValues("scripts/npc/kv/gameplay/treasure_shop.kv")
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