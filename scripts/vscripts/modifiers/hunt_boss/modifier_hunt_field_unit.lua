--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "modifiers/hunt_boss/modifier_hunt_field_unit"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_hunt_field_unit"
d(j, h)
function j.prototype.CheckState(self)
	local k = self:GetParent():GetUnitName() == "npc_hunt_field_totem"
	local l = self:GetParent():GetUnitName() == "npc_hunt_field_hunter"
	return {
		[MODIFIER_STATE_INVULNERABLE] = not k,
		[MODIFIER_STATE_UNSELECTABLE] = not k,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_ROOTED] = not l,
		[MODIFIER_STATE_DISARMED] = true,
	}
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
			}
		),
	},
	j
)
local m = c()
m.name = "modifier_hunt_totem_invulnerable"
d(m, h)
function m.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true }
end
function m.prototype.StaticProperty(self)
	return { [PropertyFunction.AVOID_DAMAGE] = 1 }
end
m = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	m
)
return f