--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_28"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__Number
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 2,
		["15"] = 5,
		["16"] = 6,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 8,
		["21"] = 7,
		["22"] = 6,
		["23"] = 5,
		["24"] = 6,
		["26"] = 6,
		["27"] = 12,
		["28"] = 19,
		["29"] = 12,
		["30"] = 19,
		["31"] = 20,
		["32"] = 21,
		["33"] = 20,
		["34"] = 25,
		["35"] = 26,
		["36"] = 26,
		["37"] = 27,
		["38"] = 28,
		["39"] = 29,
		["40"] = 30,
		["41"] = 31,
		["43"] = 25,
		["44"] = 19,
		["45"] = 12,
		["46"] = 12,
		["47"] = 12,
		["48"] = 12,
		["49"] = 12,
		["50"] = 12,
		["51"] = 12,
		["52"] = 19,
		["54"] = 19,
		["55"] = 36,
		["56"] = 43,
		["57"] = 36,
		["58"] = 43,
		["59"] = 45,
		["60"] = 46,
		["61"] = 45,
		["62"] = 48,
		["63"] = 49,
		["64"] = 48,
		["65"] = 53,
		["66"] = 54,
		["67"] = 53,
		["68"] = 58,
		["69"] = 59,
		["71"] = 59,
		["73"] = 59,
		["74"] = 59,
		["75"] = 59,
		["77"] = 59,
		["78"] = 58,
		["79"] = 43,
		["80"] = 36,
		["81"] = 36,
		["82"] = 36,
		["83"] = 36,
		["84"] = 36,
		["85"] = 36,
		["86"] = 36,
		["87"] = 43,
		["89"] = 43,
		["90"] = 62,
		["91"] = 69,
		["92"] = 62,
		["93"] = 69,
		["94"] = 72,
		["95"] = 73,
		["96"] = 74,
		["97"] = 72,
		["98"] = 76,
		["99"] = 77,
		["100"] = 76,
		["101"] = 82,
		["102"] = 83,
		["103"] = 82,
		["104"] = 87,
		["105"] = 88,
		["107"] = 88,
		["109"] = 88,
		["110"] = 88,
		["111"] = 88,
		["113"] = 88,
		["114"] = 87,
		["115"] = 69,
		["116"] = 62,
		["117"] = 62,
		["118"] = 62,
		["119"] = 62,
		["120"] = 62,
		["121"] = 62,
		["122"] = 62,
		["123"] = 69,
		["125"] = 69,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.trait_28 = c()
local o = h.trait_28
o.name = "trait_28"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_28"
end
o = e({ k(nil) }, o)
h.trait_28 = o
h.modifier_trait_28 = c()
local p = h.modifier_trait_28
p.name = "modifier_trait_28"
d(p, m)
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function p.prototype.OnBattleStart(self, q)
	local r = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
	local s = r and r.hero
	local t = s and s:GetEnemy()
	local u = self:GetAbility()
	if IsInjurable(s, t) then
		s:AddNewModifier(s, u, "modifier_trait_28_buff", {})
		t:AddNewModifier(s, u, "modifier_trait_28_debuff", {})
	end
end
p = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	p
)
h.modifier_trait_28 = p
h.modifier_trait_28_buff = c()
local v = h.modifier_trait_28_buff
v.name = "modifier_trait_28_buff"
d(v, m)
function v.prototype.GetAbilitySpecialValue(self)
	self.increase = self:GetAbilitySpecialValueFor("increase")
end
function v.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROJECTILE_SPEED_PERCENTAGE] = self.increase }
end
function v.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS }
end
function v.prototype.GetModifierProjectileSpeedBonus(self)
	local w = KeyValues.UnitsKv[self:GetParent():GetUnitName()]
	if w ~= nil then
		w = w.ProjectileSpeed
	end
	local x = w
	if x == nil then
		x = 0
	end
	return x * self.increase * 0.01
end
v = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	v
)
h.modifier_trait_28_buff = v
h.modifier_trait_28_debuff = c()
local y = h.modifier_trait_28_debuff
y.name = "modifier_trait_28_debuff"
d(y, m)
function y.prototype.GetAbilitySpecialValue(self)
	self.reduce = self:GetAbilitySpecialValueFor("reduce")
	self.evade = self:GetAbilitySpecialValueFor("evade")
end
function y.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROJECTILE_SPEED_PERCENTAGE] = -self.reduce,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROJECTILE_OFF] = self.evade,
	}
end
function y.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS }
end
function y.prototype.GetModifierProjectileSpeedBonus(self)
	local z = KeyValues.UnitsKv[self:GetParent():GetUnitName()]
	if z ~= nil then
		z = z.ProjectileSpeed
	end
	local A = z
	if A == nil then
		A = 0
	end
	return f(-A) * self.reduce * 0.01
end
y = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	y
)
h.modifier_trait_28_debuff = y
return h