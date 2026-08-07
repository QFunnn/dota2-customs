--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/spawn/modifier_breakable"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_breakable"
d(j, h)
function j.prototype.OnDestroy(self)
	if IsServer() then
		EmitSoundOn("Dungeon.SmashCrateShort", self.parent)
	end
end
function j.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_BLIND] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
function j.prototype.StaticState(self)
	return { [StateEnum.BREAKABLE] = true }
end
function j.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PROVIDES_FOW_POSITION }
end
function j.prototype.GetModifierProvidesFOWVision(self)
	return 1
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
return f