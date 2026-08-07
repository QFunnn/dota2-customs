--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_stagger"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.TransmitterData
local j = g.registerEOMModifier
local k = c()
k.name = "modifier_stagger"
d(k, h)
function k.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_SILENCED] = true }
end
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self.animation = l.animation
		if l.animation_time ~= nil then
			self.animation_rate = l.animation_time / self:GetDuration()
		end
		self:IncrementStackCount()
	end
end
function k.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
		MODIFIER_PROPERTY_DISABLE_TURNING,
	}
end
function k.prototype.GetOverrideAnimation(self)
	return self.animation or ACT_DOTA_DISABLED
end
function k.prototype.GetOverrideAnimationRate(self)
	return self.animation_rate or 1
end
function k.prototype.GetModifierDisableTurning(self)
	return 1
end
e({ i(nil) }, k.prototype, "animation", nil)
e({ i(nil) }, k.prototype, "animation_rate", nil)
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	k
)
return f