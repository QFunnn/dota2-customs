--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_40"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 2,
		["12"] = 2,
		["13"] = 2,
		["14"] = 4,
		["15"] = 5,
		["16"] = 7,
		["17"] = 8,
		["18"] = 7,
		["19"] = 8,
		["20"] = 9,
		["21"] = 10,
		["24"] = 14,
		["25"] = 15,
		["26"] = 16,
		["27"] = 16,
		["28"] = 16,
		["29"] = 16,
		["30"] = 16,
		["31"] = 16,
		["32"] = 16,
		["33"] = 16,
		["34"] = 9,
		["35"] = 23,
		["36"] = 24,
		["37"] = 23,
		["38"] = 8,
		["39"] = 7,
		["40"] = 8,
		["42"] = 8,
		["43"] = 28,
		["44"] = 35,
		["45"] = 28,
		["46"] = 35,
		["47"] = 39,
		["48"] = 40,
		["49"] = 39,
		["50"] = 43,
		["51"] = 44,
		["54"] = 48,
		["55"] = 49,
		["56"] = 50,
		["57"] = 50,
		["58"] = 50,
		["59"] = 50,
		["60"] = 50,
		["61"] = 50,
		["62"] = 50,
		["63"] = 50,
		["64"] = 50,
		["65"] = 43,
		["66"] = 61,
		["67"] = 62,
		["70"] = 66,
		["71"] = 67,
		["72"] = 67,
		["73"] = 67,
		["74"] = 67,
		["75"] = 67,
		["76"] = 67,
		["77"] = 67,
		["78"] = 67,
		["79"] = 67,
		["80"] = 61,
		["81"] = 35,
		["82"] = 28,
		["83"] = 28,
		["84"] = 28,
		["85"] = 28,
		["86"] = 28,
		["87"] = 28,
		["88"] = 28,
		["89"] = 35,
		["91"] = 35,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = "165"
local o = "n_165_reduce_pct"
g.treasure_40 = c()
local p = g.treasure_40
p.name = "treasure_40"
d(p, i)
function p.prototype.Spawn(self)
	if not IsServer() then
		return
	end
	local q = self:GetCaster():GetPlayerOwnerID()
	PlayerData:getHero(q):learnAbility(n, true)
	Notification:combatToPlayer(
		q,
		{
			message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[n].rarity),
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbilityName(),
			string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. n,
		}
	)
end
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_40"
end
p = e({ j(nil) }, p)
g.treasure_40 = p
g.modifier_treasure_40 = c()
local r = g.modifier_treasure_40
r.name = "modifier_treasure_40"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.value = self:GetAbilitySpecialValueFor("value")
end
function r.prototype.OnCreated(self, s)
	if not IsServer() then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	self.key = tostring(self:GetAbility():entindex())
	AbilityUpgrades:AddSpecialValueUpgrade(
		q,
		{
			id = self.key,
			type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE,
			description = self.key,
			ability_name = n,
			special_value_name = o,
			operator = ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD,
			value = self.value,
		}
	)
end
function r.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	AbilityUpgrades:RemoveSpecialValueUpgrade(
		q,
		{
			id = self.key,
			type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE,
			description = self.key,
			ability_name = n,
			special_value_name = o,
			operator = ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD,
			value = self.value,
		}
	)
end
r = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	r
)
g.modifier_treasure_40 = r
return g