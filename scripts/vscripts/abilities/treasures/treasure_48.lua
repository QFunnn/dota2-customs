--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_48"
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
		["15"] = 6,
		["16"] = 7,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 9,
		["23"] = 13,
		["24"] = 14,
		["25"] = 15,
		["26"] = 16,
		["27"] = 16,
		["28"] = 16,
		["29"] = 16,
		["32"] = 20,
		["33"] = 8,
		["34"] = 23,
		["35"] = 24,
		["36"] = 23,
		["37"] = 7,
		["38"] = 6,
		["39"] = 7,
		["41"] = 7,
		["42"] = 28,
		["43"] = 35,
		["44"] = 28,
		["45"] = 35,
		["46"] = 36,
		["47"] = 37,
		["48"] = 38,
		["49"] = 38,
		["50"] = 37,
		["51"] = 36,
		["52"] = 42,
		["53"] = 43,
		["54"] = 44,
		["55"] = 44,
		["56"] = 44,
		["57"] = 44,
		["58"] = 44,
		["59"] = 44,
		["60"] = 42,
		["61"] = 35,
		["62"] = 28,
		["63"] = 28,
		["64"] = 28,
		["65"] = 28,
		["66"] = 28,
		["67"] = 28,
		["68"] = 28,
		["69"] = 35,
		["71"] = 35,
		["72"] = 48,
		["73"] = 55,
		["74"] = 48,
		["75"] = 55,
		["76"] = 56,
		["77"] = 57,
		["78"] = 56,
		["79"] = 55,
		["80"] = 48,
		["81"] = 48,
		["82"] = 48,
		["83"] = 48,
		["84"] = 48,
		["85"] = 48,
		["86"] = 48,
		["87"] = 55,
		["89"] = 55,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = "42"
g.treasure_48 = c()
local o = g.treasure_48
o.name = "treasure_48"
d(o, i)
function o.prototype.Spawn(self)
	if not IsServer() then
		return
	end
	local p = self:GetCaster():GetPlayerOwnerID()
	local q = PlayerData:getHero(p)
	if q:getAbilityUpgradeLevel(n) >= SECT_ABILITY_LEVEL.r then
		PlayerData:modifyGold(p, self:GetSpecialValueFor("gold"))
		return
	end
	q:learnAbility(n, true)
end
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_48"
end
o = e({ j(nil) }, o)
g.treasure_48 = o
g.modifier_treasure_48 = c()
local r = g.modifier_treasure_48
r.name = "modifier_treasure_48"
d(r, l)
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function r.prototype.OnTraitInit(self, s)
	s.hero:RemoveModifierByName("modifier_treasure_48_buff")
	s.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_treasure_48_buff", {})
end
r = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	r
)
g.modifier_treasure_48 = r
g.modifier_treasure_48_buff = c()
local t = g.modifier_treasure_48_buff
t.name = "modifier_treasure_48_buff"
d(t, l)
function t.prototype.ECheckState(self)
	return { [EOMModifierStates.MODIFIER_STATE_MAGIC_PHYSICAL_CRIT_SWAP] = true }
end
t = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	t
)
g.modifier_treasure_48_buff = t
return g