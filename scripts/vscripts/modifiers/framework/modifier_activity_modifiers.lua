--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_activity_modifiers"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
f.modifier_activity_modifiers = c()
local j = f.modifier_activity_modifiers
j.name = "modifier_activity_modifiers"
d(j, h)
function j.prototype.GetPriority(self)
	return MODIFIER_PRIORITY_LOW
end
function j.prototype.OnCreated(self, k)
	local l = {
		KeyValues:GetUnitData(
			self.parent,
			"AttackSpeedActivityModifiers",
			"AttackRangeActivityModifiers",
			"MovementSpeedActivityModifiers"
		),
	}
	self.tAttackSpeedActivityModifiers = l[1]
	self.tAttackRangeActivityModifiers = l[2]
	self.tMovementSpeedActivityModifiers = l[3]
end
function j.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function j.prototype.GetActivityTranslationModifiers(self)
	if self.tMovementSpeedActivityModifiers == nil then
		return
	end
	if not IsValid(self.parent) then
		return
	end
	local m
	local n = self.parent:GetMoveSpeedModifier(self.parent:GetBaseMoveSpeed(), false)
	local o = -math.huge
	for p, q in pairs(self.tMovementSpeedActivityModifiers) do
		local r = toFiniteNumber(q)
		if n >= r and r > o then
			m = p
			o = r
		end
	end
	return m
end
j = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
				DestroyOnExpire = false,
			}
		),
	},
	j
)
f.modifier_activity_modifiers = j
return f