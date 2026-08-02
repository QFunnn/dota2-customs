--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_enter_gate"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifierMotionHorizontal
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_enter_gate"
d(j, h)
function j.prototype.OnCreated(self, k)
	if IsServer() then
		local l = self:GetParent()
		self.position = StringToVector(k.position)
		self.direction = CalcDirection2D(self.position, l)
		l:SetForwardVector(self.direction)
		if not self:ApplyHorizontalMotionController() then
			self:Destroy()
			return
		end
	end
end
function j.prototype.OnDestroy(self)
	if IsServer() then
		local l = self:GetParent()
		l:Stop()
	end
end
function j.prototype.OnHorizontalMotionInterrupted(self)
	if IsServer() then
		self:Destroy()
	end
end
function j.prototype.UpdateHorizontalMotion(self, m, n)
	if IsServer() then
		m:SetAbsOrigin(m:GetAbsOrigin() + self.direction * 400 * n)
	end
end
function j.prototype.StaticDeclare(self)
	return { [MODIFIER_PROPERTY_OVERRIDE_ANIMATION] = ACT_DOTA_RUN }
end
function j.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_SILENCED] = true }
end
j = e(
	{
		i(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	j
)
return f