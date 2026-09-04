--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local ____exports = {}
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____monster_warning_effects = require("modifiers.monster.monster_warning_effects")
local findHeroesInRadius = ____monster_warning_effects.findHeroesInRadius
local warningEffectLinear = ____monster_warning_effects.warningEffectLinear
local warningEffectRing = ____monster_warning_effects.warningEffectRing
--- 怪物 Modifier 基类，继承自通用 BaseModifier_CS
____exports.MonsterModifier_CS = __TS__Class()
local MonsterModifier_CS = ____exports.MonsterModifier_CS
MonsterModifier_CS.name = "MonsterModifier_CS"
__TS__ClassExtends(MonsterModifier_CS, BaseModifier_CS)
function MonsterModifier_CS.prototype.GetMinDistanceUnit(self, range, p)
	return self._parent:GetMinDistanceUnit(range, p)
end
function MonsterModifier_CS.prototype.FindHeroesInRadius(self, range, point)
	if not IsValid(nil, self._caster) or self._caster:IsNull() then
		return {}
	end
	return findHeroesInRadius(nil, self._caster:GetTeamNumber(), point or self._parent:GetAbsOrigin(), range)
end
function MonsterModifier_CS.prototype.WarningEffect(self, start_pos, end_pos, duration, options)
	warningEffectLinear(nil, self._caster, self._ability, start_pos, end_pos, duration, options)
end
function MonsterModifier_CS.prototype.WarningRingEffect(self, center, damageRadius, duration, options)
	warningEffectRing(nil, self._caster, center, damageRadius, duration, options)
end
function MonsterModifier_CS.prototype.WarningRingEffect2(self, center, damageRadius, duration, options)
	WarningRing(nil, self._caster, center, damageRadius, duration, options)
end
return ____exports