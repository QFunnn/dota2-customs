--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/forge"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayIncludes
local f = b.__TS__New
local g = b.__TS__DecorateLegacy
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 12,
		["15"] = 12,
		["16"] = 12,
		["17"] = 12,
		["18"] = 12,
		["19"] = 12,
		["20"] = 12,
		["21"] = 12,
		["22"] = 12,
		["23"] = 12,
		["24"] = 12,
		["25"] = 12,
		["26"] = 12,
		["27"] = 12,
		["28"] = 12,
		["29"] = 12,
		["30"] = 12,
		["31"] = 12,
		["32"] = 12,
		["33"] = 12,
		["34"] = 12,
		["35"] = 12,
		["36"] = 12,
		["37"] = 12,
		["38"] = 12,
		["39"] = 12,
		["40"] = 12,
		["41"] = 12,
		["42"] = 12,
		["43"] = 12,
		["44"] = 12,
		["45"] = 12,
		["46"] = 12,
		["47"] = 12,
		["48"] = 12,
		["49"] = 12,
		["50"] = 12,
		["51"] = 12,
		["52"] = 12,
		["53"] = 52,
		["54"] = 52,
		["55"] = 52,
		["56"] = 52,
		["57"] = 52,
		["58"] = 52,
		["59"] = 52,
		["60"] = 52,
		["61"] = 52,
		["62"] = 52,
		["63"] = 52,
		["64"] = 52,
		["65"] = 52,
		["66"] = 52,
		["67"] = 52,
		["68"] = 68,
		["69"] = 68,
		["70"] = 69,
		["72"] = 69,
		["73"] = 70,
		["74"] = 71,
		["75"] = 72,
		["76"] = 68,
		["77"] = 74,
		["78"] = 75,
		["79"] = 76,
		["80"] = 77,
		["81"] = 78,
		["83"] = 80,
		["84"] = 80,
		["85"] = 80,
		["86"] = 80,
		["87"] = 80,
		["88"] = 74,
		["89"] = 84,
		["90"] = 85,
		["93"] = 88,
		["94"] = 84,
		["95"] = 91,
		["96"] = 92,
		["97"] = 91,
		["98"] = 95,
		["99"] = 95,
		["100"] = 95,
		["102"] = 96,
		["105"] = 99,
		["106"] = 100,
		["107"] = 101,
		["109"] = 95,
		["110"] = 105,
		["111"] = 106,
		["112"] = 107,
		["113"] = 108,
		["116"] = 111,
		["117"] = 112,
		["118"] = 113,
		["119"] = 114,
		["120"] = 115,
		["123"] = 118,
		["124"] = 119,
		["125"] = 119,
		["126"] = 120,
		["127"] = 121,
		["128"] = 122,
		["129"] = 123,
		["130"] = 124,
		["134"] = 105,
		["135"] = 130,
		["136"] = 131,
		["139"] = 134,
		["140"] = 135,
		["144"] = 138,
		["145"] = 138,
		["146"] = 139,
		["147"] = 138,
		["150"] = 130,
		["151"] = 143,
		["152"] = 144,
		["154"] = 145,
		["155"] = 145,
		["156"] = 146,
		["157"] = 145,
		["160"] = 148,
		["161"] = 148,
		["162"] = 148,
		["163"] = 149,
		["164"] = 143,
		["165"] = 152,
		["166"] = 153,
		["167"] = 154,
		["168"] = 155,
		["170"] = 156,
		["171"] = 157,
		["173"] = 159,
		["174"] = 160,
		["176"] = 162,
		["177"] = 163,
		["182"] = 166,
		["183"] = 152,
		["184"] = 169,
		["185"] = 170,
		["186"] = 171,
		["188"] = 172,
		["189"] = 172,
		["190"] = 173,
		["191"] = 174,
		["192"] = 175,
		["193"] = 176,
		["195"] = 172,
		["198"] = 179,
		["199"] = 169,
		["200"] = 182,
		["201"] = 183,
		["202"] = 184,
		["205"] = 187,
		["206"] = 188,
		["209"] = 191,
		["210"] = 192,
		["211"] = 193,
		["214"] = 196,
		["215"] = 197,
		["216"] = 197,
		["217"] = 197,
		["218"] = 197,
		["219"] = 197,
		["220"] = 198,
		["221"] = 199,
		["222"] = 197,
		["223"] = 197,
		["224"] = 197,
		["225"] = 197,
		["226"] = 197,
		["227"] = 197,
		["228"] = 182,
		["229"] = 203,
		["230"] = 204,
		["231"] = 205,
		["234"] = 208,
		["235"] = 209,
		["236"] = 210,
		["237"] = 211,
		["238"] = 212,
		["239"] = 212,
		["240"] = 212,
		["241"] = 212,
		["242"] = 212,
		["243"] = 212,
		["244"] = 212,
		["245"] = 212,
		["246"] = 203,
		["247"] = 68,
		["248"] = 224,
		["249"] = 225,
	}
)
local i = {}
local j = require("class.weight_pool")
local k = j.CWeightPool
local l = require("lib.tstl-utils")
local m = l.reloadable
local n = {
	item_counter_critcal_chance = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_COUNTER_CRITICAL_CHANCE },
	item_ability_life_steal = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_ABILITY_LIFESTEAL },
	item_reduce = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE, multiplier = -1 },
	item_health = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS },
	item_ulti_power = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER },
	item_attackspeed = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS },
	item_physical_armor = {
		property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE,
		multiplier = -1,
	},
	item_magical_armor = {
		property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE,
		multiplier = -1,
	},
	item_mana_regen = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BONUS },
	item_attack = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS },
	item_physical_damage = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_PHYSICAL_DAMAGE_PERCENTAGE },
	item_magical_damage = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_MAGICAL_DAMAGE_PERCENTAGE },
	item_damage = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE },
	item_fury_count = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_STACK_BONUS },
	item_ice_count = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_STACK_BONUS },
	item_shield_count = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_STACK_BONUS },
	item_injury_count = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_STACK_BONUS },
	item_poison_count = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_STACK_BONUS },
	item_permanent_fury = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_PERMANENT },
	item_permanent_ice = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_PERMANENT_SOURCE },
	item_permanent_shield = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_PERMANENT },
	item_permanent_injury = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_PERMANENT_SOURCE },
	item_permanent_poison = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_PERMANENT_SOURCE },
	item_poison_damage = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_DAMAGE_BONUS },
	item_permanent_chaos = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_PERMANENT },
	item_regen = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_BONUS },
	item_crit = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS },
	item_crit_damage = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE },
	item_evade = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS },
	item_wisp_regen = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_REGEN },
	item_wisp_health = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_HEALTH_BONUS },
	item_wisp_interval = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_INTERVAL, multiplier = -1 },
	item_lifesteal = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_LIFESTEAL },
	item_evade_damage = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVADE_DAMAGE_REDUCE_BONUS_PERCENT },
	item_chaos_count = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_STACK_BONUS },
	item_chaos_damage_bonus = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_DAMAGE_BONUS },
	item_state_resistance = { property = EOMModifierFunction.EOM_MODIFIER_PROPERTY_STATE_RESISTANCE },
}
local o = {
	sect_attack = { "item_attack", "item_physical_damage" },
	sect_crit = { "item_crit", "item_crit_damage", "item_counter_critcal_chance" },
	sect_regen = { "item_regen", "item_lifesteal", "item_ability_life_steal" },
	sect_health = { "item_health" },
	sect_ulti = { "item_ulti_power", "item_mana_regen", "item_magical_damage" },
	sect_poison = { "item_poison_count", "item_permanent_poison", "item_poison_damage" },
	sect_ice = { "item_ice_count", "item_permanent_ice" },
	sect_fury = { "item_fury_count", "item_permanent_fury" },
	sect_shield = { "item_shield_count", "item_permanent_shield" },
	sect_injury = { "item_injury_count", "item_permanent_injury" },
	sect_wisp = { "item_wisp_regen", "item_wisp_health", "item_wisp_interval" },
	sect_chaos = { "item_chaos_count", "item_permanent_chaos", "item_chaos_damage_bonus" },
	sect_evade = { "item_evade", "item_evade_damage" },
}
local p = c()
p.name = "CForge"
d(p, CModule)
function p.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.disabledSource = {}
	self.legendaryRewardRecord = {}
	self.maxLevelRewardRecord = {}
end
function p.prototype.init(self, q)
	if not q then
		self.disabledSource = {}
		self.legendaryRewardRecord = {}
		self.maxLevelRewardRecord = {}
	end
	CustomUIEvent("forge_request_roll", function(r, s)
		return self:OnRequestRoll(s)
	end, self)
end
function p.prototype.SetSourceDisabled(self, t, u)
	if not IsInToolsMode() then
		return
	end
	self.disabledSource[t] = u
end
function p.prototype.IsSourceDisabled(self, t)
	return IsInToolsMode() and self.disabledSource[t] == true
end
function p.prototype.Reward(self, v, t, w)
	if w == nil then
		w = 1
	end
	if self:IsSourceDisabled(t) then
		return
	end
	local x = FORGE_FRAGMENT_REWARD[t] or 0
	if x > 0 and w > 0 then
		PlayerData:modifyForgeFragment(v, x * w)
	end
end
function p.prototype.OnAbilityLearn(self, v, y, z)
	local A = KeyValues.AbilityUpgradesKvs[y]
	local B = PlayerData:getHero(v)
	if not A or not B then
		return
	end
	if z and A.rarity == "sr" then
		self.legendaryRewardRecord[v] = self.legendaryRewardRecord[v] or {}
		if not self.legendaryRewardRecord[v][y] then
			self.legendaryRewardRecord[v][y] = true
			self:Reward(v, "legendary")
		end
	end
	if A.rarity == "n" or A.rarity == "r" then
		local C = B:getAbilityUpgradeData(false, true)[y]
		local D = C and C.level or 0
		if D >= A.MaxLevel then
			self.maxLevelRewardRecord[v] = self.maxLevelRewardRecord[v] or {}
			if not self.maxLevelRewardRecord[v][y] then
				self.maxLevelRewardRecord[v][y] = true
				self:Reward(v, "maxlevel")
			end
		end
	end
end
function p.prototype.AddBannedSectAttributes(self, E, F)
	if F == nil then
		return
	end
	local G = o[F]
	if G == nil then
		return
	end
	do
		local H = 0
		while H < #G do
			E[G[H + 1]] = true
			H = H + 1
		end
	end
end
function p.prototype.GetBannedAttributeRecord(self, v)
	local E = {}
	do
		local H = 0
		while H < #AbilityShop.banList do
			self:AddBannedSectAttributes(E, AbilityShop.banList[H + 1])
			H = H + 1
		end
	end
	local I = self.AddBannedSectAttributes
	local J = PlayerData:getplayerData(v)
	I(self, E, J and J.bannedSect)
	return E
end
function p.prototype.GetAttributePool(self, v)
	local K = self:GetBannedAttributeRecord(v)
	local L = {}
	for M, N in pairs(FORGE_ATTRIBUTE_VALUES) do
		do
			if e(FORGE_ATTRIBUTE_EXCLUDE, M) then
				goto O
			end
			if K[M] then
				goto O
			end
			if n[M] ~= nil and N > 0 then
				L[M] = 1
			end
		end
		::O::
	end
	return f(k, L)
end
function p.prototype.RollAttributeList(self, v, P)
	local Q = self:GetAttributePool(v)
	local R = {}
	do
		local H = 0
		while H < P do
			local M = Q:random()
			if M then
				R[#R + 1] = M
				Q:remove(M)
			end
			H = H + 1
		end
	end
	return R
end
function p.prototype.OnRequestRoll(self, s)
	local v = s.PlayerID
	if not PlayerData:isAlivePlayer(v) then
		return
	end
	if PlayerData:getForgeFragment(v) < 10 then
		ErrorMessage(v, "error_not_enough_forge_fragment")
		return
	end
	local S = self:RollAttributeList(v, 3)
	if #S < 3 then
		ErrorMessage(v, "error_no_forge_attribute")
		return
	end
	PlayerData:modifyForgeFragment(v, -10)
	Selection:AddSpecialSelection(v, "forge_attribute", S, function(r, R)
		self:ApplyAttribute(v, R)
		return true
	end, nil, nil, true, true)
end
function p.prototype.ApplyAttribute(self, v, T)
	local U = n[T]
	if U == nil then
		return
	end
	local V = FORGE_ATTRIBUTE_VALUES[T] or 0
	local N = V * (U.multiplier or 1)
	PlayerData:modifyForgeAttribute(v, T, V)
	TeamCard:AddAttributeValue(v, U.property, N)
	Notification:combatToPlayer(
		v,
		{
			message = "notify_attribute_gain_str",
			string_attribute = "dota_tooltip_item_variable_" .. T,
			string_value = tostring(math.abs(N)),
		}
	)
end
p = g({ m }, p)
if _G.Forge == nil then
	_G.Forge = f(p)
end
return i