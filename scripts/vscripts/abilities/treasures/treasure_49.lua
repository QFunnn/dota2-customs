--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_49"
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
		["22"] = 9,
		["23"] = 8,
		["24"] = 7,
		["25"] = 8,
		["27"] = 8,
		["28"] = 14,
		["29"] = 21,
		["30"] = 14,
		["31"] = 21,
		["32"] = 25,
		["33"] = 26,
		["34"] = 27,
		["35"] = 25,
		["36"] = 30,
		["37"] = 31,
		["40"] = 35,
		["41"] = 36,
		["42"] = 36,
		["43"] = 36,
		["44"] = 36,
		["45"] = 36,
		["46"] = 36,
		["47"] = 36,
		["48"] = 43,
		["50"] = 44,
		["51"] = 44,
		["52"] = 45,
		["53"] = 44,
		["56"] = 30,
		["57"] = 49,
		["58"] = 50,
		["61"] = 54,
		["62"] = 54,
		["63"] = 54,
		["64"] = 54,
		["65"] = 54,
		["66"] = 54,
		["67"] = 54,
		["68"] = 54,
		["69"] = 54,
		["70"] = 54,
		["71"] = 49,
		["72"] = 21,
		["73"] = 14,
		["74"] = 14,
		["75"] = 14,
		["76"] = 14,
		["77"] = 14,
		["78"] = 14,
		["79"] = 14,
		["80"] = 21,
		["82"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = "80"
local o = "80_effect_1"
g.treasure_49 = c()
local p = g.treasure_49
p.name = "treasure_49"
d(p, i)
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_49"
end
p = e({ j(nil) }, p)
g.treasure_49 = p
g.modifier_treasure_49 = c()
local q = g.modifier_treasure_49
q.name = "modifier_treasure_49"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.stunDuration = self:GetAbilitySpecialValueFor("stun_duration")
end
function q.prototype.OnCreated(self, r)
	if not IsServer() then
		return
	end
	local s = self:GetParent():GetPlayerOwnerID()
	AbilityUpgrades:AddAbilityMechanicsUpgrade(
		s,
		{
			ability_name = n,
			type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS,
			id = o,
			values = { effect_1 = self.stunDuration },
			description = o,
		}
	)
	local t = PlayerData:getHero(s)
	do
		local u = 0
		while u < self.count do
			t:learnAbility(n, true)
			u = u + 1
		end
	end
end
function q.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	AbilityUpgrades:RemoveAbilityMechanicsUpgrade(
		self:GetParent():GetPlayerOwnerID(),
		{
			ability_name = n,
			type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS,
			id = o,
			values = { effect_1 = self.stunDuration },
			description = o,
		}
	)
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_treasure_49 = q
return g